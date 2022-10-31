Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6059D6140E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJaWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJaWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:53:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B9140BE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:53:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g129so11931972pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIhxAHEvGp1AmipgOU4ochFbfH4MLAxumap99RbQ2Kg=;
        b=UPE14pLYmbjc8vK+oNlYzitPk2hVcQc9fyMjBjMNL3lMtWLp5mPEYdnj1YewxG2IDR
         mvBKdr3TPNUaauzFfJHjRwXt7tYn404a2JDAmRMliWzgTZ+zQ30XE+RXtPU0KS9QfypK
         Z5QRFasxHH4n4wp9pgu1cTRNqIjxT2G6xdWqNW0dhlJQiMOgptSNo5J2WmBGpETo3Lkh
         eIJhFt1JeOE7v7dLX7k6waqhfiJ6A+HyR04D270OJ2nrbToO5E9/09Ur8qVxPIMUZs0/
         mS2SiOEdP0rId+02YhU5xReYM6gPuK/AWgSQw7PSshW9i5TzxLGodxtrqqDYaU3kckp8
         E0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIhxAHEvGp1AmipgOU4ochFbfH4MLAxumap99RbQ2Kg=;
        b=wd3BgUYWQ6d5ocfz0Kiq2r6jR296GlxYso6CxUUtym7lyP8AFIeMY7kM8wRsytjoxb
         PS2nUagxq6iMTAKeYoPNPqXQ+arawd5jH8FiWZ/5RkeFF3FlfFN8JvUORYH56XgWkWY9
         kUw8QAFRrPXmlCT5gp6w7ddS5VpU7xvHa1ZWiWL1BIXclHyaJZVlWlQliZycwQZCBMYT
         oejIkTTDw3RnIbLznMeVNrtWmF/v62lHuodMM8bEgQU1JG0vMeDQfpMouN+6JUAlGQx+
         zKHJj/5BFnZhRnsmh3LJJm3Ul8C9qcgFPZ5gHPkn+RImFM6vMK3vwFqb0exQ7FgqFpQZ
         7/rQ==
X-Gm-Message-State: ACrzQf2zAJ+4JYG9zXnZDr8hXYxXRGu0coaXXxEW0Yh6XNUNU+EPG4xb
        dLGHPII2ybLeV2wBdhdSy1M=
X-Google-Smtp-Source: AMsMyM4CQF1f4+QOl/cQc8qddvsKJANCOpAlsnArL7MZPxmTSV8Puv5bwA65pCKIokdNSHJMI1F6Pw==
X-Received: by 2002:a62:d412:0:b0:56c:6f25:8b12 with SMTP id a18-20020a62d412000000b0056c6f258b12mr16566301pfh.60.1667256783549;
        Mon, 31 Oct 2022 15:53:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b0017b69f99321sm4951844plh.219.2022.10.31.15.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:53:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 12:53:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in
 kernfs_next_descendant_post (2)
Message-ID: <Y2BRzPxroVylPLan@slm.duckdns.org>
References: <000000000000c183f505eb721745@google.com>
 <20221021225228.1750-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021225228.1750-1-hdanton@sina.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Luis for firmware loader and quoting the whole body)

On Sat, Oct 22, 2022 at 06:52:28AM +0800, Hillf Danton wrote:
> On 20 Oct 2022 00:15:40 -0700
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1449d53c880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e01c72880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128908c880000
> 
> See if the change to ueagle driver alone can survive syzbot test.
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  aae703b02f92
> 
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3663,8 +3663,9 @@ static inline bool netif_attr_test_online(unsigned long j,
>  static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
>  					       unsigned int nr_bits)
>  {
> -	/* n is a prior cpu */
> -	cpu_max_bits_warn(n + 1, nr_bits);
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpu_max_bits_warn(n, nr_bits);
>  
>  	if (srcp)
>  		return find_next_bit(srcp, nr_bits, n + 1);
> @@ -3685,8 +3686,9 @@ static inline int netif_attrmask_next_and(int n, const unsigned long *src1p,
>  					  const unsigned long *src2p,
>  					  unsigned int nr_bits)
>  {
> -	/* n is a prior cpu */
> -	cpu_max_bits_warn(n + 1, nr_bits);
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpu_max_bits_warn(n, nr_bits);
>  
>  	if (src1p && src2p)
>  		return find_next_and_bit(src1p, src2p, nr_bits, n + 1);
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -597,9 +597,8 @@ static int uea_send_modem_cmd(struct usb
>  }
>  
>  static void uea_upload_pre_firmware(const struct firmware *fw_entry,
> -								void *context)
> +					struct usb_device *usb)
>  {
> -	struct usb_device *usb = context;
>  	const u8 *pfw;
>  	u8 value;
>  	u32 crc = 0;
> @@ -679,6 +678,7 @@ static int uea_load_firmware(struct usb_
>  {
>  	int ret;
>  	char *fw_name = EAGLE_FIRMWARE;
> +	const struct firmware *fw;
>  
>  	uea_enters(usb);
>  	uea_info(usb, "pre-firmware device, uploading firmware\n");
> @@ -701,13 +701,13 @@ static int uea_load_firmware(struct usb_
>  		break;
>  	}
>  
> -	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
> -					GFP_KERNEL, usb,
> -					uea_upload_pre_firmware);
> +	ret = request_firmware(&fw, fw_name, &usb->dev);
>  	if (ret)
>  		uea_err(usb, "firmware %s is not available\n", fw_name);
> -	else
> +	else {
>  		uea_info(usb, "loading firmware %s\n", fw_name);
> +		uea_upload_pre_firmware(fw, usb);
> +	}
>  
>  	uea_leaves(usb);
>  	return ret;

So, the problem is that while request_firmware_nowait() inc's the ref on the
device, if the device gets removed later, having a ref isn't sufficient for
adding stuff to the device. A relatively easy solution would be putting
these firmware load work items into its own workqueue and flushing it on
device removal path. Luis, what do you think?

Thanks.

-- 
tejun
