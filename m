Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A76A83C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCBNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCBNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:48:14 -0500
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3D13D4F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:48:12 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:48:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677764890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V991dQeEws4gMfHQC4nmHWlHaA6flpJIWdTN0Wx42VA=;
        b=Fcy93b3rfXouCdwjKyg+iGKp3SkD6tfNB6iH1jBLaidKblWBulqy1/6N33ZhE7PQ2U89Oc
        FWZgZyWjDb60c09PWCc5c+vmAJbdZJiJnYy8rBYFQI969EAN7InJi2dkI+z+glnGLk16Md
        aDN7gmpcqImu8UqsUtd96EVxEp2tWHk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
Message-ID: <ZACpGN5Qk26Q8U9K@g0hl1n.net>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
 <27aa0b4a-14fc-5fce-ab49-a8744b131882@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27aa0b4a-14fc-5fce-ab49-a8744b131882@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:31:14PM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2023 12:55, richard.leitner@linux.dev wrote:
> > From: Richard Leitner <richard.leitner@skidata.com>
> > 
> > Convert from max9867.txt to maxim,max9867.yaml and add missing
> > '#sound-dai-cells' property.
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> Except wrong ID (and missing test):
> 
> > +
> > +examples:
> > +  - |
> > +    &i2c {
> > +            max9867: max9867@18 {
> 
> Generic node names, so "codec" and drop the unused label.

Thanks for the review and feedback. I'll fix that in v2.

> 
> Use 4 spaces for example indentation.

Ok. checkpatch.pl didn't complain about that so I thought this was
fine. Are there any other scripts/tools to check for correct formatting
of bindings?

> 
> > +                    compatible = "maxim,max9867";
> > +                    #sound-dai-cells = <0>;
> > +                    reg = <0x18>;
> 
> Best regards,
> Krzysztof
> 

Thanks & regards;rl
