Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44586701864
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjEMRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEMRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785230EB;
        Sat, 13 May 2023 10:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593DA60EDF;
        Sat, 13 May 2023 17:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ACFC433D2;
        Sat, 13 May 2023 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683997829;
        bh=TOsr602S/RiQVVUfqbfRhzGS9/Eifb0+BN9LSRdNr78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lh0wMKDvEd2Ef6l/Ovtuv+jWZm4cXCOGipS3Z+UZRtl0Nc7Dz20O9Er0aRQntPFDe
         +so7fE0bhPwUip5pUnrmaCFXyCfkjOvPZsiQ22LHD3pN7bfVQDy0fsbGuulbmI/5fB
         vGzvgTlkadAJh4NM3V7rMVWnTY9Le1f+KwVFvb62HQX+saKwR6ura7OpePu6tQZ2Bz
         MGCEC0GSTc0J3U8lAdTOB2a6Xa86d6sNVu0mGaa/8U+caBM8zWXk270mQ8grdjMJOS
         2KRyOqYt43YfoRPHINv1Hq9obye3z5qt/Xm/EWuvwZV7jOX9bx/9LQAiSRcsls9s+t
         UJqMlvo6h8ISg==
Date:   Sat, 13 May 2023 18:26:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230513182629.398447b4@jic23-huawei>
In-Reply-To: <7cafafd3-e7a7-96db-0f8f-ac5c8bc94d13@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
        <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
        <20230501152014.7789aa42@jic23-huawei>
        <91463df1-5aba-484a-92ea-f8979ec30535@fi.rohmeurope.com>
        <20230507152236.46aba096@jic23-huawei>
        <7cafafd3-e7a7-96db-0f8f-ac5c8bc94d13@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 19:13:38 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/7/23 17:22, Jonathan Cameron wrote:
> 
> >>> If there is nothing to do in the actual interrupt as it's a data ready
> >>> only signal, then you should just call iio_trigger_poll() in the top half and
> >>> use devm_request_irq() only as there is no thread in this interrupt (though
> >>> there is one for the interrupt below the software interrupt chip).  
> >>
> >> I haven't tested this yet so please ignore me if I am writing nonsense -
> >> but... The BU27008 will keep the IRQ line asserted until a register is
> >> read. We can't read the register form HW-IRQ so we need to keep the IRQ
> >> disabled until the threaded trigger handler is ran. With the setup we
> >> have here, the IRQF_ONESHOT, took care of this. I assume that changing
> >> to call the iio_poll_trigger() from top-half means I need to explicitly
> >> disable the IRQ and re-enable it at the end of the trigger thread after
> >> reading the register which debounces the IRQ line?  
> > 
> > Hmm. I'm trying to remember how this works (wrote this a very long time ago).
> > I'm fairly sure it's not an issue because we use IRQF_ONESHOT down one level
> > so exercise the same prevention of the threads triggering multiple times etc >   
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57
> > 
> > It doesn't matter if the device interrupt fires again as it will still be masked
> > at our software irqchip level and will then get queued up and the thread will
> > run again.  
> 
> After reading this I am not at all sure I am using the trigger 
> correctly. I see the iio_trigger_attach_poll_func() registering threaded 
> handler with the IRQF_ONESHOT which is stored in the 
> iio_alloc_pollfunc() as you pointed above.
> 
> The iio_trigger_attach_poll_func() is called from sysfs callback when 
> trigger is enabled. So, if this is supposed to be the device IRQ, then I 
> am not at all sure the driver should be requesting the IRQ at the 
> probe(). If it is not the device's IRQ, then I guess the IRQF_ONESHOT 
> passed in here won't help. I need to try seeing some examples how other 
> drivers are using the triggers. Getting back to this tomorrow...

I think you are confusing two different irqs here / I managed to confuse
you even more.

The one in iio_trigger_attach_pollfunc() is a child of the trigger - it's
called when the trigger 'fires' along with any other children attached
(if multiple IIO devices have current_trigger set tot his one).
The one you are registering for is the parent of the trigger and calls
iio_poll_trigger() in it's handler which in turn will result in interrupts
for any children of the trigger (that is the pollfunc's which are
interrupt handlers underneath).

Not sure this horrible diagram will help

    Data Ready Interrupt
            |
 iio_trigger_poll() after checking it's right int etc. Easy here.
            |
    ________|__________________________________________________________________
    |                             |                                  |         |
 Pollfunc 1 Int              Pollfunc 2 Int
    |                             |
 Top half of PF 1           Top half of PF2 return IRQ_THREAD etc
    |                             |
.....................................
    |                             |
 Thread PF 1                 Thread PF 2
    |                             |
iio_push_to_buffers..()    iio_push_to_bufffers..()
For trigger consumer       For trigger consumer
device 1                   device 2.

So in the pollfunc interrupts have IRQF_ONESHOT set so the masking happens
in the internal irq_chip that IIO uses to handle this demux of the
trigger signal to multiple different sensor drivers to make them grab
data to push into buffers.  This whole thing is built to enable
sync capture of multiple signals where possible (hardware restrictions
mean this only works for some combinations).
Years ago, we had our own registration scheme that didn't use interrupts
internally and it was pointed out (Arnd Bergmann I think...) that we
were just replicating what goes on in an interrupt chip so should use
that instead.

Jonathan

> 
> Yours,
> 	-- Matti.
> 

