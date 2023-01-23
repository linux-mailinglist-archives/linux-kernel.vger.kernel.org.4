Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB5678AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjAWWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:39:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03732E71
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:39:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so12915765plw.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ09l3R22DsPHcvZ2kO5x0wMzr7pSOmqqpqJPjHAMnM=;
        b=ptbesqMh8rbAJMxXpsdnsHTv2AffZ4etaVZORvyeYqniCVQ9DaDHloPH/xjs16LWk2
         6tcBKu6fVC3MJJJxSl34R9OumrKuGOwaOOFVej7MiqRQ+njCzsaG8Q5uW9plnpDuGcmv
         j6vnSSJgzzmHA4PvHtCMAVk1C/zLQeFRKaIorG0l4feQIxDI1YZcjYINMTAJgXajFilK
         8qGRmkxgefuBpyfLR+mln7bZuOhCH5GLgzqa/cXj6vBci4XY0K+u/d4vnsHCPVdLYTHC
         +/ASckCWlulqKu7Olf2JMiHc1NQ92t5PAxEOn07XtBwU4ihhlZR0WOVXU7DpctoflHIj
         +VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ09l3R22DsPHcvZ2kO5x0wMzr7pSOmqqpqJPjHAMnM=;
        b=hm77Nntwq9X7DPbcEDQPcup46MYsT3A7no9asMClM5yMdj3D7bb3mMEi0d95Zr6XgX
         BbB43f++iD7s2C4x2PaGNvg3ADuAdhb2GsKeAF4SL7J5wOGFCNJ2VqWvzmAWGSHnAY1I
         GUSIp4klDDTjZb99s+4IhSq3eZdL3JzFMY87CTsW5byVc9m0m/+P93DJsAq+ORjijdDM
         Y+mBjdsLuTGvtTb57PhXlUE9+P3aTBq2cpl4OCBPSPHcnOst0zV+XCpQ9oidGBYpYtLE
         Fc67pZi+Axd8uvZ0Ve5XKPgHtczxT3raywN6k293H8KJ1cTcdsHW8mv6CvurwbD4jQ7B
         XEnQ==
X-Gm-Message-State: AFqh2krJFsT85OD/z0DNDDYyG/iPg6Bv+GUvFYfZ4yMNN9XpRBH6d6hP
        3/99pofKpwcNTgfdohsNwbjFijwH6MtETEdCfwVz9w==
X-Google-Smtp-Source: AMrXdXsIY7kXekH4EZ7XdBD8bjl10zRULHBdyBUqj1hk4VBKFNHfJMa0KsQL+oK/DIXTkYYi7B1DTnHcTpaJS2OYFD0=
X-Received: by 2002:a17:90b:48d0:b0:226:b5f4:d420 with SMTP id
 li16-20020a17090b48d000b00226b5f4d420mr3552600pjb.102.1674513550980; Mon, 23
 Jan 2023 14:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20230123222220.405622-1-mcgrof@kernel.org>
In-Reply-To: <20230123222220.405622-1-mcgrof@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Jan 2023 14:38:59 -0800
Message-ID: <CAKwvOd=uah7DxBfkLMnhS1hYRZxHVnW5z++auRYhGWbKZ+C0Qg@mail.gmail.com>
Subject: Re: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW
 contact for Qualcomm
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Trilok Soni <tsoni@quicinc.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 2:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Emails to tsoni@codeaurora.org bounce from different systems I've used
> and LinkedIn tells me he's now at Linaro since 2019. That's a 4 year
> gap where embargo stuff goes to /dev/null for Qualcomm if the first
> bounce happened in 2019, but I have no way of knowing when that account
> was disactivated for sure.

Perhaps it's now tsoni@quicinc.com and we should update this doc and .mailm=
ap?

>
> Cc: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>
> David, should we apply this for now until you guys figure out a proper co=
ntact?
>
>  Documentation/process/embargoed-hardware-issues.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Docume=
ntation/process/embargoed-hardware-issues.rst
> index fbb754253cf7..bf06e0d45776 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -250,7 +250,6 @@ an involved disclosed party. The current ambassadors =
list:
>    IBM Power    Anton Blanchard <anton@linux.ibm.com>
>    IBM Z                Christian Borntraeger <borntraeger@de.ibm.com>
>    Intel                Tony Luck <tony.luck@intel.com>
> -  Qualcomm     Trilok Soni <tsoni@codeaurora.org>
>    Samsung       Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
>
>    Microsoft    James Morris <jamorris@linux.microsoft.com>
> --
> 2.35.1
>


--=20
Thanks,
~Nick Desaulniers
