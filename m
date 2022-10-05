Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122C5F56B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJEOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJEOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:50:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B954D148;
        Wed,  5 Oct 2022 07:50:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qx23so17919043ejb.11;
        Wed, 05 Oct 2022 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xLMos+tgD1eCVdBIBgEE+0UeEzSJf5JfsDYdO7x7ZE0=;
        b=aH3wHq6pdoqlwf3maO4hw35nDos/l6DHFEj4IHjKsCW2pHZW9+AnAt/FsTiThwsOvf
         8rSLr66ZTjqoE86FNkvEz338RJXzIG4uhhmKdjQxy/9UEDhMLzrlLTBGIGR96PnoSClv
         gHyJEkV115ehu7c2Q1jQq7a0xtS+m+vx7i8FxlMW3OQ3NIO1bNgmslX2HOWG7o/m8P8a
         300y9w7ubFIicCWLgWR8aaQMxx++jtLVYEGtZj6i9hjQwptMI9CeHOSer0wIHn5iu9yH
         Rb70WMuR50KoGbtJfhxS1a40yGqHGxQXrqDIXxh/NDvTuOYacKL9d+ODVdZwacz86+qF
         DcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xLMos+tgD1eCVdBIBgEE+0UeEzSJf5JfsDYdO7x7ZE0=;
        b=3oqIigjxlOmjFu5x2QYsodOiWWiMp/8uTndlkuZOygvjOUtmio9NRZ5YhLoK6vacuq
         +nS9o8XXR6CwCM0NsNVNn6IKoRTkQUQYZ+Getu2uJOs+7UuPhpH4Y9+xuLbIiFucZbLM
         U2aCIk0Lehq+ukvwkK7s5Jk1nj1XufSV/f2wZ7XGUdFdVxuRvDK/AM9qWYzXxSP7r0/Q
         YX2STEKk/ScLgd/zPzCKtCBVUQzx6PhELaf8cK7aPNhy381W7sBwBfvTvNE4qEX5a3g7
         nOB0tnm0rnH7hB5DFSrTqjTan+1eLgP7wP8qjQQZHkSOiiw8cmUynwIOik8Q27ZPLOGb
         O1Ew==
X-Gm-Message-State: ACrzQf1Hg5rNUazdJn1YvoMYkyPHIBY1Raeogy3kEILTHCmO7/KLJ9qF
        E8Z6l6vg5Q4/2McTKNNpDCE=
X-Google-Smtp-Source: AMsMyM4t9zssa/TaQLyPzwjSl9HJ3ZezzxrCq8qKVBTV3KRW6E7BRLegZndoGjEfKUoPUHfptwzrXA==
X-Received: by 2002:a17:907:31c3:b0:770:852b:71a2 with SMTP id xf3-20020a17090731c300b00770852b71a2mr24056401ejb.557.1664981421681;
        Wed, 05 Oct 2022 07:50:21 -0700 (PDT)
Received: from michael-VirtualBox (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078d38cda2b1sm512321ejc.202.2022.10.05.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:50:21 -0700 (PDT)
Date:   Wed, 5 Oct 2022 17:50:18 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     Enrik Berkhan <Enrik.Berkhan@inka.de>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>,
        Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v2 4/7] HID: ft260: support i2c reads greater than HID
 report size
Message-ID: <Yz2ZqiDvkO1ePB4k@michael-VirtualBox>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
 <20220928144854.5580-5-michael.zaidman@gmail.com>
 <28932c5e2250c68e07ef5fafe3bee42653fd62f5.camel@inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28932c5e2250c68e07ef5fafe3bee42653fd62f5.camel@inka.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:11:37PM +0200, Enrik Berkhan wrote:
> Hi Michael,
> 
> On Wed, 2022-09-28 at 17:48 +0300, Michael Zaidman wrote:
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index bfda5b191a3a..cb8f1782d1f0 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -460,49 +460,68 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
> >  static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
> >  			  u16 len, u8 flag)
> >  {
> > +	u16 rd_len;
> > +	int timeout, ret;
> >  	struct ft260_i2c_read_request_report rep;
> >  	struct hid_device *hdev = dev->hdev;
> > -	int timeout;
> > -	int ret;
> > +	bool first = true;
> >  
> > -	if (len > FT260_RD_DATA_MAX) {
> > -		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
> > -		return -EINVAL;
> > -	}
> > +	do {
> > +		if (first) {
> > +			if (flag & FT260_FLAG_START_REPEATED)
> 
> I think the test should be
> 
>     if ((flag & FT260_FLAG_START_REPEATED) == FT260_FLAG_START_REPEATED)
> 
> Otherwise, flag will never be FT260_FLAG_START ( = 2), as
> FT260_FLAG_START_REPEATED (= 3) has tow bits set. It looks as if bit 0
> actually means "repeated", bit 1 is "start" and bit 2 is "stop".
> 
> Cheers,
> Enrik
>

Thanks for reviewing the code!

Though the FT260 works fine with the FT260_FLAG_START_REPEATED flag at the
beginning of the I2C IO, I will fix it as you suggested.

Thanks,
Michael

