Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF15FFCEA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJPBhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 21:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJPBhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 21:37:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E43DF3A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 18:37:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5EB0132004ED;
        Sat, 15 Oct 2022 21:37:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 15 Oct 2022 21:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1665884229; x=1665970629; bh=us
        mHFGZvtUt3GSrq2Da8mcGY9SS5vOoXDl/cCx8LI4E=; b=D1iA3Gfp6IRKKyYKla
        BGRWT6HV5ORZH3XntIHzxDDGMqcVx7p2s3/kC6hjta14oSTfn+j9WyjmvvuVyxPB
        sx+IYrSNRlm977dUesZ0Hvv3gFIQ4sZbhyNPCf+ylitZCHlmnOhe2adbvv0D/zqW
        mSD+VzB1UNtvf4FYjxm/XCpLfR/rzAJcQ7k9R8VkCBHuYvmF/MG2eyA19eKzxmO5
        a8wLo32zN19JGyDI1dEFqZ4rhskaodQybEtQJ6SRc0348495RxwNpKBuQK1W1AMw
        r2VcqR4K1Oy5i+ptOTf4Lh/ssHCBsh6+xLfS6CK4Ln8TkbZGHYM5b8RORNdYFtAV
        RwCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665884229; x=1665970629; bh=usmHFGZvtUt3GSrq2Da8mcGY9SS5
        vOoXDl/cCx8LI4E=; b=gI8Q9MaeKVW5znaEdWUAn1R/4/m8GhHiqlrdrdkIECPV
        VbGrYV36EbOjjZkAoGw2s3xv1enK+b+y1oyyrlQFY42TZ0m5WmY+b5SepEihJqwG
        J4Vk3u607VvjrQVgEObD0mCwSDBO4vF2eaH0gYz11YdUfA+5Bs+1X5KkaIjxM5fy
        gV4Wo7UuhWYTkHzm6zfrb7RgJiY4HMOg815V3x/+vssDb7pBY/gLkFeNcmq3tfZp
        WQTwKjlsbZsOTAiORlfb4k9Cy6rSEjTz1QNq7FLmhji6H06cqAOmkwS+LYTAGjip
        kk8kLOsMXmh6q6lV5pHx4C2LTqH1YcSL7xapIu/PDw==
X-ME-Sender: <xms:RWBLY8RnzOVWus9YllghGCXsdDG_F36upd0Nj22k79zJzbq07jihfw>
    <xme:RWBLY5xi6GXxPEKzUcMU6SxX5vDJE5NSAIaIw5mJuRztnCKRz4l5TVfC7xISl47Ph
    S7nKj1jh8tfK1BdYws>
X-ME-Received: <xmr:RWBLY518ulMsXKM94RXlbP3nvJuWy21yTj55IS3qwOJ5Ux7EkkaRrx1VzU7acdMkZ26XPpOJz3SFCfHpMJe8hUaH2SrvbHFPwFqN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepgeetuddtgffhfeeuiefggeeljeeuleelteelgfdu
    gfdtkeeiffetleeugfdtffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghrtg
    hhihhvvgdrohhrghdpudefleegthgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
    hirdhjph
X-ME-Proxy: <xmx:RWBLYwCJ-30EGDlAe1yFn39CNlCh2PY56FBnt221LYQawXE6_1UA-A>
    <xmx:RWBLY1gZcym1328Ugoc_pGuOzJE__MX2wCdW5zUdk_MGuOetwCrfdQ>
    <xmx:RWBLY8p2zTyh9ijua02YkuSLSfhQOrvwa1kRBHzeEl2hVNIVMHWMqw>
    <xmx:RWBLY4v5FuNZxCTlhwq8tozncg2jAyYH0XNyNo5R70CXmrN7q7-bfw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Oct 2022 21:37:07 -0400 (EDT)
Date:   Sun, 16 Oct 2022 10:37:05 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sound: dice: Firestudio Mobile
Message-ID: <Y0tgQah2qTmOt6KA@workstation>
Mail-Followup-To: George Hilliard <thirtythreeforty@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221015233330.8679-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015233330.8679-1-thirtythreeforty@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 15, 2022 at 06:33:28PM -0500, George Hilliard wrote:
> This short series adds a configuration block for the Firestudio Mobile I
> just acquired.  Very similar to the Firestudio, but a lower port count.
> 
> My understanding is that the Low, Medium, and High speeds refer to
> 48kHz, 96kHz, and 192kHz sample rates, of which only the first two are
> supported by this hardware line.  Please correct me if this is not
> correct.
> 
> Thanks!

Thanks for the patches, while the device, FireStudio Mobile, is
already supported by ALSA dice driver since it has an entry of moddevice
table which matches your device:

```
	{
		.match_flags = IEEE1394_MATCH_VERSION,
		.version     = DICE_INTERFACE,
	},
```

I think you have the other troubles except for device detection.


In general protocol defined by TC Applied Technologies (the company
which designed DICE ASICs and firmwares), two fields of content of
configuration ROM have pre-defined values.

One of the fields is version field of unit directory. The value is
0x000001 (=DICE_INTERFACE). In your case, the content of unit directory
is below. We can see the value of version field is 0x000001.

```
               unit directory at 430
               ---------------------------------------------------
430  00048030  directory_length 4, crc 32816
434  12000a92  specifier id: Presonus Corporation
438  13000001  version
43c  17000011  model
440  8100000f  --> descriptor leaf at 47c
```

Another is EUI-64 field in bus information block. the part of field
is used for 8 bit `category ID` and the value is 0. In your case,
the value is below. The way to parese the field, please refer to
`check_dice_category` function in `sound/firewire/dice/dice.c`[1].

```
               ROM header and bus information block
               ---------------------------------------------------
400  0404bc6a  bus_info_length 4, crc_length 4, crc 48234
404  31333934  bus_name "1394"
408  e0008102  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 0, max_rec 8 (512)
40c  000a9204  company_id 000a92     | Presonus Corporation
410  047da647  device_id 04047da647  | EUI-64 000a9204047da647
```

For the content of configuration ROM itself, documentation by 1394
Trading Association (vendor association back in several years ago) will
be a great help[2].


As a supplement, TCAT general protocol has no way to share available
stream formats at all of supported sampling transfer frequencies. It
allows software just to read available stream formats at current
sampling transfer frequency, while TCAT protocol extension has the
function.  ALSA dice driver is programmed to try the extension to detect,
then works at limitation mode at failure. The pre-defined table you coded
is for the case that the extension is not supported by device, but
your device supports the extension.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/dice/dice.c#n33
[2] https://web.archive.org/web/20210216003042/http://1394ta.org/wp-content/uploads/2015/07/1999027.pdf


Thanks

Takashi Sakamoto
