Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA468DDF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBGQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:28:44 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4C1A5;
        Tue,  7 Feb 2023 08:28:43 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16a7f5b6882so2363944fac.10;
        Tue, 07 Feb 2023 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XI6Rbsn9O4Ky4P8KlbFZdfXngJlkXBuGuGn6ubsxjEU=;
        b=gpAHr4Q/cfIU5nGSdQbdDMupU+9XMMPcdR4tUCgFEj/Kvn+iAmC2SQcnsTR7oHzOy0
         tNpZsscob6a2jWE3kwBUX2Q34+lKRIb+DdDKfhgQqykgT6w6AS3qLUZRZUQiZxGcPA9o
         v/BVGUg2ufvQL4hA51MoYTIBRcgVWYArwE/wr5YGdDFJn06iyFZSaaN4oAT2X/DUGX6M
         hoACxHl6XL2jYxDPgHgk/tXRIAtktS2SQcm/CNtILql5enNoY0z7LWXNTdOs3MWWtVh/
         pC2090xrHB0EA4ZrBz0gnBrRUW3uxn3uTWQ952jSQd95ht4vbDgE64VaY5tt0r5kKiQ+
         VyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI6Rbsn9O4Ky4P8KlbFZdfXngJlkXBuGuGn6ubsxjEU=;
        b=pnO2qXJCsFDNrKmv5bvM1XfpIvo+cE56WqTJqygK/bTxGAiFg2adBxnsZmVPN/Ze1J
         n5acqHdetlPnDzmuzXSsiMBJRkeLBhlQ+kddmYDw40/+wohoukyqgmyo4SfIZkzXpPsw
         l/lGN29iJD6P6jG7+SGr1+mveguR+Lu3HJRWWUsUToQxENABBBueCKQhzhYnSbb1ih40
         xI4PbYhMgLgEBMkd2JSQaCMHRjFcl5t3LE1XBi+M9aL2zMTm4vut8M9lIzVe0sVX+AnE
         cn7pJjF7e6L3q37REgXYrxJgA3xPGKn1/fjaNRBztFq73gXyGnisnN77+1sezysBqtiF
         XmIA==
X-Gm-Message-State: AO0yUKWDun1aIqYWgaBRZARG3/5L/P+1rmVyJ87n8VWn/74MSTZjE4Ri
        XF8Ln7EAcDreZ4TBkGdanYkB7xpphoCb3HwsW5Fmth/W
X-Google-Smtp-Source: AK7set8ewQ6nSRT+x986Io37kBZPo079R4GPuq050dU9NtKJP5cy8TYzDgIEHCiJrnIsU2u1fR28ySXBhbUR4qadgC0=
X-Received: by 2002:a05:6870:2186:b0:163:babd:12e with SMTP id
 l6-20020a056870218600b00163babd012emr792588oae.146.1675787322533; Tue, 07 Feb
 2023 08:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20221227001001.51626-1-zh.nvgt@gmail.com> <9b0f6779-e2a5-54f1-2b9c-6bc42c6d3d90@redhat.com>
 <CAO2zrtbaz2XF+vHW6mC_+gUNwwkWffupbp2jg8_sWgcguy5AKA@mail.gmail.com> <859bdf0d-8679-e4aa-5c0e-49ead7e62059@redhat.com>
In-Reply-To: <859bdf0d-8679-e4aa-5c0e-49ead7e62059@redhat.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Tue, 7 Feb 2023 11:28:32 -0500
Message-ID: <CAO2zrtYgcYJRM-P0JHbCofjxmpxWCO=3Wqo7AiW1pZ-7nZ_=4g@mail.gmail.com>
Subject: Re: [PATCH] scsi: dpt_i2o: fix a potential use-after-free in __adpt_reset()
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 10:34 AM Tomas Henzl <thenzl@redhat.com> wrote:
>
> On 2/3/23 21:05, Hang Zhang wrote:
>
> On Fri, Feb 3, 2023 at 11:07 AM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Hi Hang,
>
> with b04e75a4a8a8 scsi: dpt_i2o: Remove obsolete driver
> was the driver removed from kernel.
>
> Regards,
> Tomas
>
> Hi Tomas, thank you very much for pointing this out! I'm wondering
> that is this removal for all the kernel versions, or there might still be
> some maintained versions using this driver (e.g., from a quick check
> it seems the longterm 5.15.91 still has the driver)? If so, do you think
> this is a valid issue that we need to fix in some prior affected
> longterm kernel versions? Thank you for your help and comments!
>
> It is now removed from the mainline, it can stay elsewhere
> for an uncertain time.
> If there is a mechanism how to fix patches only in those longterm kernels I don't know.
> Ask in related mailing lists.
> I think that when the driver is now eol and this issue hasn't been noticed
> before, it's likely not worth the effort to fix it now.
>
Hi Tomas, thank you for the reply. We will try to gather more information
about this. Thanks!

Best,
Hang
>
> Best,
> Hang
>
> On 12/27/22 01:10, Hang Zhang wrote:
>
> __adpt_reset() invokes adpt_hba_reset(), which can free "pHba"
> on error paths and return an negative error code in those
> situations. The problem is that "pHba" is from the global pointer
> "cmd->device->host->hostdata[0]", regardless of the possible free
> of "pHba", that original global pointer is never nullified and
> thus may become a dangling pointer and be dereferenced later,
> potentially causing a use-after-free.
>
> Fix the issue by nullifying "cmd->device->host->hostdata[0]" if
> adpt_hba_reset() returns a negative error code to __adpt_reset(),
> which indicates the free of "pHba". Also add a NULL check before
> any dereference of "pHba", or the aliased global pointer. Note
> that the similar NULL check already exists at other places, like
> in adpt_queue_lck().
>
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>  drivers/scsi/dpt_i2o.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> index 2e9155ba7408..9827517a1898 100644
> --- a/drivers/scsi/dpt_i2o.c
> +++ b/drivers/scsi/dpt_i2o.c
> @@ -753,6 +753,9 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>   char name[32];
>
>   pHba = (adpt_hba*)cmd->device->host->hostdata[0];
> + if (!pHba) {
> + return FAILED;
> + }
>   strncpy(name, pHba->name, sizeof(name));
>   printk(KERN_WARNING"%s: Hba Reset: scsi id %d: tid: %d\n", name, cmd->device->channel, pHba->channel[cmd->device->channel].tid);
>   rcode =  adpt_hba_reset(pHba);
> @@ -760,6 +763,7 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>   printk(KERN_WARNING"%s: HBA reset complete\n", name);
>   return SUCCESS;
>   } else {
> + cmd->device->host->hostdata[0] = NULL;
>   printk(KERN_WARNING"%s: HBA reset failed (%x)\n", name, rcode);
>   return FAILED;
>   }
>
>
>
