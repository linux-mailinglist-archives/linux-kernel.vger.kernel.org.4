Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C46E8E71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjDTJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjDTJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:45:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ACEC;
        Thu, 20 Apr 2023 02:43:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 65F195C01D4;
        Thu, 20 Apr 2023 05:43:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 20 Apr 2023 05:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681983837; x=1682070237; bh=JN
        uBSeuFArrnXcjQI1NqfWJ20b+N0NUjMnaQcUcsvxY=; b=JR93K6Dh6DRU+wpNBn
        3aFJ/1S/eotBO7DJFBgtgZRis64ZpiUNpwwqnhqcBqpWgiU2Sh0rtH8btuN+H/il
        kcelnAR5GOgplRnqmNkZOgO/t2x67jsviU7xlRGQMA+t2Yqh82OFzB3ETCG4+gLA
        EkbsoWinNYuSMRlzx+fozROqyPs/YxSxnCTfHvVhjioRmO4k4FDRwyonkLVHZNoH
        ZtmjXnu9M20JClrgBal3/ob9ZYNdR0fNKidZzX89Q+sNkhMrzh8nvUywA5yRc5EQ
        QbKvJti5c+EiIveqpuNmBkcTyREftGxYdGPmKfq7wjuWBOUPbyMEJofocBC/KOnI
        FCPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681983837; x=1682070237; bh=JNuBSeuFArrnX
        cjQI1NqfWJ20b+N0NUjMnaQcUcsvxY=; b=gN9HPFmqhvTMUIJLqpKtNj2UMhdDD
        8sD6TvDeg5b1VVbnx85cA7XvvqW22ZS7Xn8tGz2Jv11spnHNDp40ec352eABN3a2
        ShnY9J5wt1X6DWV2730Dck4dKDl2cqwet5yIlUUDXne3W1fJ+wmIzP+gwrhdY3bJ
        fQsnENDr8/RfQ6EMLcyEewHv30ox5gPCM6HJdH7Ar7QM1V1enL6Vux8Dak3o/xIB
        OA7k31wgmfDNYBSxFX/wQP2E65VZQVDg1tD/q1RAWyoBEuNblli2IZYkuJ2KwoL0
        ziI+xbghmsTn4H4lo/RZxTU3GlaqfOndVkevpPQ9oVhZmOmdNLlOoSs3Q==
X-ME-Sender: <xms:XAlBZAEfnzjhuoIsLenVkMNFAa37gS3pBA6QsrVtoyAg1KAWE-9RBA>
    <xme:XAlBZJU1fcwycQ28heUFhUL2nIBcALqOlioi3Bomh7ecR6KfM5gkBLVSBJzxk46j5
    2kvUVQ95yfjuDRBVug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XAlBZKIGMCJSRcKRmivh9TwZUsro0gjG8QJx0wFqCH3dVMikg6OyFg>
    <xmx:XAlBZCHLo5IIGJ1L16LHrW5zlZIch6xqq-F6pMUwR1tmPERVMQIdQw>
    <xmx:XAlBZGXn7LR3jrOSTraW4AiYcUSxw8aKSGOkbmxkdXFMlcaNIJjWiA>
    <xmx:XQlBZPMcIBTGMETA8WiRInfkqz8O13100GFfuPm6jA_vUCOYXJRb2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BA86B60086; Thu, 20 Apr 2023 05:43:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <7e54e105-574a-4104-8781-2f15c0c4b329@app.fastmail.com>
In-Reply-To: <20230420090101.80812-3-pawell@cadence.com>
References: <20230420090101.80812-1-pawell@cadence.com>
 <20230420090101.80812-3-pawell@cadence.com>
Date:   Thu, 20 Apr 2023 11:43:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Pawel Laszczak" <pawell@cadence.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daisy.Barrera@siriusxm.com, Cliff.Holden@siriusxm.com,
        "Tony Lindgren" <tony@atomide.com>,
        "Jean Delvare" <jdelvare@suse.de>, neal_liu@aspeedtech.com,
        "Linus Walleij" <linus.walleij@linaro.org>, egtvedt@samfundet.no,
        "Biju Das" <biju.das.jz@bp.renesas.com>, herve.codina@bootlin.com
Subject: Re: [PATCH v2 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023, at 11:00, Pawel Laszczak wrote:
> This patch introduces the main part of Cadence USBHS driver
> to Linux kernel.

Not sure why I was on Cc, but I gave it a quick look anyway, looking
for common issues. I only found a few very minor things that can be
improved, no real problems:

> +++ b/drivers/usb/gadget/udc/cdns2/Kconfig
> @@ -0,0 +1,11 @@
> +config USB_CDNS2_UDC
> +	tristate "Cadence USBHS Device Controller"
> +	depends on USB_PCI && ACPI && HAS_DMA

Why the ACPI dependency?

> +	response_pkt = (__le16 *)pdev->ep0_preq.request.buf;
> +	*response_pkt = cpu_to_le16(status);

You can simplify this using put_unaligned_le16()

> +
> +	preq->num_of_trb = num_trbs;
> +
> +	/*
> +	 * Memory barrier - cycle bit must be set as the last operation.
> +	 */
> +	wmb();

This can probably be the cheaper dma_wmb() if you only serialize
between accesses to a DMA buffer.

> +static int __maybe_unused cdns2_pci_suspend(struct device *dev)
> +{
> +	struct cdns2_device *priv_dev = dev_get_drvdata(dev);
> +
> +	return cdns2_gadget_suspend(priv_dev);
> +}
> +
> +static int __maybe_unused cdns2_pci_resume(struct device *dev)
> +{
> +	struct cdns2_device *priv_dev = dev_get_drvdata(dev);
> +
> +	return cdns2_gadget_resume(priv_dev, 1);
> +}
> +
> +static const struct dev_pm_ops cdns2_pci_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cdns2_pci_suspend, cdns2_pci_resume)
> +};

You can use SYSTEM_SLEEP_PM_OPS() instead of SET_SYSTEM_SLEEP_PM_OPS()
and then remove the __maybe_unused.

       Arnd
