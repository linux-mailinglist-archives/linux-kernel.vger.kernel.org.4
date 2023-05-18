Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96661708B89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjERW0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjERW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:26:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE4E50
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:26:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B78F75C00E7;
        Thu, 18 May 2023 18:26:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 18 May 2023 18:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1684448792; x=
        1684535192; bh=6TwGgJbBVoZV95OFOrW5qUj6HCHeiZRKa7KzYY7F1mg=; b=E
        vWSMR2s4WTMKBUieZOSrmpN+9MI1n8S3Efa9oWlQCGFG9fgHTxxd96RFURKl154d
        ULoCNWAzdS1NimT4SteO+B5qJr5/OfBUBr8mHZpOgCybWF0msMnT6npHmft97ZID
        YJGcpvL1cjz31VvhAMH4NPp7YBw766M3XbxmSf0+qhPnxkqtB8FgmKfadvtxs9pM
        UF8dRl/uCWPUnIBDTHA9zYGxhrAbLDm2knPh4kvrLvLKj0AohwMqp1zZQDqx5y1T
        0E8pW+V9Z8xJwXIhZTnJjpFReIG2hAIWaNtlg0+QsE9/wJalC0WSy2My5Npz2fpG
        +CLgIIYiB+kw4v26enirA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1684448792; x=1684535192; bh=6
        TwGgJbBVoZV95OFOrW5qUj6HCHeiZRKa7KzYY7F1mg=; b=CI/1R4yYIaTvkAF2V
        2s3rR2F/S7H1PSztrI10gu3k8kHmmBzOtbvBStMcaXhcbPRG+w96IADmAsPeQJCM
        8G34s6EnWqGWoqReyTERnizPkT9QIwoMyGWoSEGEzo4FBeSiGCXSbKRE6AwHlPrY
        5vDhnhWG/5N3FxG5TZSRCOjwDqE4kiFNON5ft2GpeUvq6hX23Knl+gU2fHBGowxi
        n1MuTuKvtbL/L13aCoObDZaf6q0v1b/8ZqkYSC8oyfiMdKZNZfytZOGdzt5fqrDr
        OO/p7n1G6DBUvd7fid2XutBAPhZoLNdBYd76lgPh9xfuy/R6S2b4kbBt0u5Q3Ieu
        zZxrA==
X-ME-Sender: <xms:F6ZmZLxR-KJOjDA2PTxY5Eo9DJhTchs95xMMqehGHPGtclbFAVwG3A>
    <xme:F6ZmZDTRbyayWrzAhYGleNbl5yrUUCpTIwkn2jdmE3JeBTNMuws6CKvDO48owuqEn
    7o8hId96sGqp3cx1pg>
X-ME-Received: <xmr:F6ZmZFUj4b7rsDd7fJ6MvhwVHJZ32YnuCl1FH7HA7sf-jlbt_siVA4VnnbNp9X9YBLAtow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgggfgtsehtufertd
    dttddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpedugfdtfedtkeekhfdthedugfdufeeghfehffekje
    dukeeljeehleduffeuhfejjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghr
    nhgvlhdrohhrghdpshhpihhnihgtshdrnhgvthdplhhinhhugihmihhnthdrtghomhdphh
    hprdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:F6ZmZFjV2RhmD_Z_S_-zVv4y5LMNYkYIB0hGxRLDUVNVuFKEKFBW4A>
    <xmx:F6ZmZNCq0INHpUlEH7JJ9Hy9xjrRs-qvdv4jm4V_X6Jv1iqbX3ACDA>
    <xmx:F6ZmZOI29vG_fRS-d53d06sRvAgsxyF8hskUn3AkpWCE-xaS-hdKBg>
    <xmx:GKZmZFZopau2GuThF3VngsOL-Yyf1nvfy_kc6BcfnyqPyPNmL3zWUg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 18:26:26 -0400 (EDT)
From:   Luke Jones <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     tiwai@suse.com, sbinding@opensource.cirrus.com, perex@perex.cz,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com, armas@codux.tech,
        ealex95@gmail.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Subject: CSC3551 and devices missing related _DSD bits
Date:   Fri, 19 May 2023 10:26:22 +1200
Message-ID: <1991650.PYKUYFuaPT@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi (and all others),

We're beginning to encounter more and more laptops from ASUS in the ROG range 
where the bass speakers are connected to a cirrus amp, and the driver for 
cirrus is unable to pick this up due to being missing a _DSD section in the 
ACPI (SSDT). I've emailed engineers at ASUS I have contact with about this but 
it is unlikely that we will see corrections for each and every model + variant 
they have. The models we have seen so far are:
- GX650P
- GU604V
- GA402X
And there have been numerous forum postings in various places with the exact 
same issue for other models from ASUS that are not in the ROG group I deal 
with - oh and also some Lenovo and HP devices also.

Some of the logs are:

[    5.542312] Serial bus multi instantiate pseudo device driver CSC3551:00: 
Instantiated 2 I2C devices.
[    5.717261] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Error: ACPI _DSD 
Properties are missing for HID CSC3551.
[    5.717269] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: error -EINVAL: 
Platform not supported
[    5.717286] cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.0 failed with 
error -22
[    5.717734] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Error: ACPI _DSD 
Properties are missing for HID CSC3551.
[    5.717737] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: error -EINVAL: 
Platform not supported
[    5.717750] cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.1 failed with 
error -22

and:

[    3.343851] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Error: ACPI _DSD 
Properties are missing for HID CSC3551.
[    3.343854] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: error -EINVAL: 
Platform not supported
[    3.343855] cs35l41-hda: probe of spi1-CSC3551:00-cs35l41-hda.0 failed with 
error -22
[    3.345544] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: Error: ACPI _DSD 
Properties are missing for HID CSC3551.
[    3.345546] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: error -EINVAL: 
Platform not supported
[    3.345548] cs35l41-hda: probe of spi1-CSC3551:00-cs35l41-hda.1 failed with 
error -22

So there are SPI connected, and I2C connected.

Alex has already submitted the related patch_realtek work for the GU604V and 
no doubt there will be some follow up patches from myself or others for the 
other models. Alex has attempted to patch the Cirrus related parts in kernel 
direct with:
1. https://github.com/bno1/linux-xanmod-gu604/blob/acpi-hack/
patch03_gu604v_speaker_acpi_hack.patch
2. https://github.com/bno1/linux-xanmod-gu604/blob/acpi-hack/
patch04_gu604v_spi_cs_gpio_hack.patch
both of these patches have been tested and working for over a week.

From what I see the patch04_gu604v_spi_cs_gpio_hack patch needs to shift to 
the cirrus driver sound/pci/hda/cs35l41_hda.c, and that driver must now have a 
quirk table - unless we can somehow add the cirrus related bits to the realtek 
code? I've personally not played with this beyond keeping an eye on it all and 
am reluctant to begin work on a solution until I've had some input on the 
direction it should take.

In any case, this is not an isolated issue and we could benefit from putting 
in place some quirk or similar to accommodate for laptops where the vendor for 
some reason does not include the _DSD parts for use with the cirrus driver. 
The trend is looking so far like this practice will continue regardless of the 
vendor.

Known reports:
- https://bugzilla.kernel.org/show_bug.cgi?id=216194
- https://www.spinics.net/lists/alsa-devel/msg146434.html
- https://gist.github.com/lamperez/862763881c0e1c812392b5574727f6ff
- https://forums.linuxmint.com/viewtopic.php?t=392762
- https://h30434.www3.hp.com/t5/Notebook-Operating-System-and-Recovery/Envy-x360-2022-13-b0074TU-Audio-not-working-in-Linux-Fedora/td-p/8644641

Regards,
Luke



