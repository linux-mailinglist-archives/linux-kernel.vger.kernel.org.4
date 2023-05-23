Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C670E5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbjEWTrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEWTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:47:34 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 12:47:33 PDT
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D96E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:47:33 -0700 (PDT)
Received: from eig-obgw-6018a.ext.cloudfilter.net ([10.0.30.233])
        by cmsmtp with ESMTP
        id 1VRpqAf4AbK1V1XxKqRIm3; Tue, 23 May 2023 19:46:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id 1XxJqUP6ky1hc1XxJqzSQA; Tue, 23 May 2023 19:46:01 +0000
X-Authority-Analysis: v=2.4 cv=cqSILn0i c=1 sm=1 tr=0 ts=646d17f9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=kxGpGzF3zFx1SGUESVUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ljMdlDdx5J+18DhoS8j4K1VQdJl1syC7905CE3fxYNA=; b=Z6e4ETW7+WGTJoQk8juniRCmgr
        IfMLlfnM8z86BSWy81Z2wZqu6Qleuoj1q5/a+xsO7Wxqh4sTzrUpwQPI9VZZEIq3kkNczH00G0qBn
        9CA6KqwjkjkC8O5VWHmfjLbJmEq+WM/0LSEmooPD4U4LMHg7xDDy+GZVF4DD2RFJ8iGfT2tAvPwtf
        Kum244yx6WE0kMVyHIiBSBdgKRp1wfcq4ZD83t0FsHyh8bow7GYqC0pnFgSlQmo4FcE2pPVAYdDpa
        fheb+OMtYLyQfg0YXaSoUaeEUN7EYc8JGw2/l4hDGMihz1ctWtClFJbEgRN1TM6WcWZoLNoruHQbY
        ic0Z+YFA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58740 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q1XxI-003bHK-HH;
        Tue, 23 May 2023 14:46:00 -0500
Message-ID: <3d298c36-cdd8-62bd-2fef-c2ce63e662ef@embeddedor.com>
Date:   Tue, 23 May 2023 13:46:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1684358315.git.gustavoars@kernel.org>
 <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
 <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com> <202305231031.C9E6124@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202305231031.C9E6124@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1q1XxI-003bHK-HH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:58740
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHSLqbsEI4XYmqErvjbzgvVIY1zgLB9q2k08Imppv54JFI9OEkpgRbfFAUiN0AorQfZUrXjv5lVZ2+4p4VJgeDU34VvQzzp2CKiPOrKpMq4Okufk0v3W
 Ctf1lpCnILRSWzq/y4ifFMYx4x7cTFbDwY1/s/D0j/noV5EX8GuOcnEXjfbAeamS9ihUGdWlWVSE0n7P0mCYn6Zo5+N8wAIzaaszQRuJPIJESmLUJkTMaDra
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 11:31, Kees Cook wrote:
> On Mon, May 22, 2023 at 06:02:21PM -0400, Martin K. Petersen wrote:
>>
>> Gustavo,
>>
>>> One-element arrays are deprecated, and we are replacing them with flexible
>>> array members instead. So, replace one-element arrays with flexible-array
>>> members in a couple of structures, and refactor the rest of the code,
>>> accordingly.
>>>
>>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>>> routines on memcpy() and help us make progress towards globally
>>> enabling -fstrict-flex-arrays=3 [1].
>>>
>>> This results in no differences in binary output.
>>
>> Applied to 6.5/scsi-staging, thanks!
> 
> Martin, I think this patch is not right -- can you drop this from
> staging for the moment?

Martin just took patch 1/2, which is correct:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=6.5/scsi-staging&id=e90644b0ce2d700a65579ac74ff594414e8ba30f

--
Gustavo
