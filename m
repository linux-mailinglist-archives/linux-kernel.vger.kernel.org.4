Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8165FFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAFLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjAFLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:49:15 -0500
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9577148D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:49:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 4NpM7W69wBz2xNg
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:references:message-id
        :in-reply-to:subject:subject:from:from:date:date:received
        :received:received:received:received:received:received:received;
         s=dwd-csg20210107; t=1673005751; x=1674215352; bh=u7IIxirkt76f0
        g/Rwq/qlgaw6SWFuad1KaMroHH8eUE=; b=bwfjMXHgqF6FghmQdDCzPVjv7640e
        Q0/ZzeOZB5cHjIRDZeznpLErC02KtmYLyw2O9qWea5NDMLxDFunqdkdlyQ6eE9cb
        jIHeA96n1+kJgN+skQUU9/6eEnNQDpV4tLFk/avU21Cm850B9PBrLp274lhK5PQn
        aW8n/5NmrWpYM/mJRtd15mn0Qjk76xW9DJpBkmAQLcsMRnpiirYrRw0VfsRCIisb
        kZl0isSUkhFmn3mDSPJGz/pmEzsdlhBUvGv2ID2zH5fydToRytn4L549d+Uuec7z
        XJNLsSfviXJALa1xcgYBprjU/3Wqcxbq8MmM3A89seNlfg+cAB5GNP4yA==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn3.dwd.de [172.30.232.26]) (amavisd-new, port 10024)
 with ESMTP id QxDMB-HAuyYb for <linux-kernel@vger.kernel.org>;
 Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A2FB7C902CE2
        for <root@ofcsg2dn3.dwd.de>; Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 97B84C900F6B
        for <root@ofcsg2dn3.dwd.de>; Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.26])
        by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn3.dwd.de>; Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Fri, 06 Jan 2023 11:49:11 -0000
Received: from ofcsg2dvf2.dwd.de (ofcsg2dvf2.dwd.de [172.30.232.11])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTPS id 4NpM7W3wZjz2xMJ;
        Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofldap.dwd.de [141.38.39.208])
        by ofcsg2dvf2.dwd.de  with ESMTP id 306BnB0j022256-306BnB0k022256;
        Fri, 6 Jan 2023 11:49:11 GMT
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.44.45])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 451534529B;
        Fri,  6 Jan 2023 11:49:11 +0000 (UTC)
Date:   Fri, 6 Jan 2023 11:49:11 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Add flexible array member for SGLs
In-Reply-To: <20230106053153.never.999-kees@kernel.org>
Message-ID: <7cc1efed-1241-112d-2a12-6abeea323284@diagnostix.dwd.de>
References: <20230106053153.never.999-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-FEAS-Client-IP: 141.38.39.208
X-FE-Last-Public-Client-IP: 141.38.39.208
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.0.1002-27368.007
X-TMASE-Result: 10--11.765800-10.000000
X-TMASE-MatchedRID: scwq2vQP8OH/9O/B1c/Qy65i3jK3KDOoC/ExpXrHizxnyL8x0tKlOwpz
        5A3IIcOFQMOJEqjTDADg9GpkpL2zRfvwmMFLImuh72Rb2bEJC+14/L/eKkYod2vlGb+24NaZwis
        nIbO8h0PqNXg27YCW5IyCITJXo1Pu38rWKQkiws4y0WOtNS62pHLhUU/qa4OGXfUB/fqAxpO4kR
        SZ1g8ZJSurxuGphsNqV5Y/cGuAJ/uR9GF2J2xqM/7E6GNqs6ce3x1YNh2+qanUZxEAlFPo846HM
        5rqDwqtp9yvkxek7WN9ypEcdRqjcrWm5vJecezqWXZQfz2GkfqotqABjxieXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023, Kees Cook wrote:

> struct MPI2_RAID_SCSI_IO_REQUEST ends with a single SGL, but expects to
> copy multiple. Add a flexible array member so the compiler can reason
> about the size of the memcpy(). This will avoid the run-time false
> positive warning:
>
>  memcpy: detected field-spanning write (size 128) of single field "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 (size 16)
>
> This change results in no binary output differences.
>
> Reported-by: Holger Kiehl <Holger.Kiehl@dwd.de>
> Link: https://lore.kernel.org/all/88de8faa-56c4-693d-2d3-67152ee72057@diagnostix.dwd.de/
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: megaraidlinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Holger, are you able to test this change? I expect it should do the
> trick, but I don't have the hardware.
>
Yes, that does work. I no longer see 'memcpy: detected field-spanning
write (size 128)'. Tested this on 6.1.4-rc1. Did not see any other
regression.

Regards,
Holger
