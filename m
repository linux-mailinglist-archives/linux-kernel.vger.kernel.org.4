Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75D968CDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBGECE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBGECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:02:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0476EBA;
        Mon,  6 Feb 2023 20:01:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so9629559pgh.7;
        Mon, 06 Feb 2023 20:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u35Hh623m0Ti9+XiOqdM6XEjf5/jkT6avmV1lNHoY4g=;
        b=Xy3AceaCQSm69lFpkSSfWsSIgQipirrahVFV6DqTbuGRyaqePOpKuvs/yPu2uXoHzF
         Zm3QHuxGZIxIMvY8Gn+mXPiL4DAcPcUM1kEHhvbGDBiWJwCHaEnnwAZW4tSebanuEckX
         NPPM2X9rnmFyJKP2/DWGkjmfqid5T9egd9MRKbP5ialcW++QBifDvgqdkzBNokN2ZOm8
         wYQFJOgHYy+rbwlGT+QUT8MHGgIeviLbq0FRWMBhM5McbY8cT0VYZVGOLbIIw9O8fRQ0
         OwImGh/kZ5mZCCSZewRQRqmDiiNYkaInTafXCkkXrIf4FoeVFdE2eTUqHX2AltVr3M7N
         8xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u35Hh623m0Ti9+XiOqdM6XEjf5/jkT6avmV1lNHoY4g=;
        b=ozaJSiVgskG8fUgnAvchRZuOVK069pxzWT6uImQ2otIyKeSqIEnfwevkXgOt4ZCkNY
         crucLoWMSM9eKpMTv8z9Iery78eeic0vu9uJvOoHJgzGbiQe+/Q5Fo/40y8soZEpo82q
         JYoxc44v944/HZn+5twg6R6ho1uWldtz9P7Kizu+Oo9fLtTqWf9r8EWRTVts5QdpBVb4
         8fCGDUOw76CGf3YcvwpbPpk3akDdhoyLzXsGsbyiy2UM28LyKxY0YjJYmHSDdf3tEcnt
         SohkPRGT2L8r5jG5i4WdD6rc7L26wIgFM11NUctf2fDRM02FTo1rmjswVbzosnzryk0Y
         TYVA==
X-Gm-Message-State: AO0yUKWXSQOIBgzzjJbBlWzV/P4kSUmxIJveYGs70/IA/v2f66bUHV+2
        bxJ1n9GbRpnYOycI96B+m6sZXpcAHLU=
X-Google-Smtp-Source: AK7set8cjKJsqdEYmERlrhVHWmL2I7wUMYwveGZuE6SpRDge4IPjIQSbgMDAs3cjaNqllkHrTvC6Dg==
X-Received: by 2002:aa7:94ad:0:b0:590:74f1:8c8a with SMTP id a13-20020aa794ad000000b0059074f18c8amr1685260pfl.15.1675742516170;
        Mon, 06 Feb 2023 20:01:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c930:81ab:3aec:b9cb])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b0058d92d6e4ddsm607689pfn.5.2023.02.06.20.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:01:55 -0800 (PST)
Date:   Mon, 6 Feb 2023 20:01:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: HID: i2c-hid: goodix: Add
 mainboard-vddio-supply
Message-ID: <Y+HNMF2ZHCOAeEqO@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.5.Ia77a96c6c5564f9cc25e6220b5a9171d5c2639e8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206184744.5.Ia77a96c6c5564f9cc25e6220b5a9171d5c2639e8@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:14PM -0800, Douglas Anderson wrote:
> The goodix i2c-hid bindings currently support two models of
> touchscreen: GT7375P and GT7986U. The datasheets of both touchscreens
> show the following things:
> * The mainboard that the touchscreen is connected to is only expected
>   to supply one voltage to the touchscreen: 3.3V.
> * The touchscreen, depending on stuffing options, can accept IO to the
>   touchscreen as either 3.3V or 1.8V. Presumably this means that the
>   touchscreen has its own way internally to make or deal with 1.8V
>   signals when it's configured for 1.8V IO.
> 
> NOTE: you've got to look very carefully at the datasheet for the
> touchscreen to see that the above bullets are true. Specifically, the
> datasheet shows a signal called VDDIO and one might think that this is
> where a mainboard would provide VDDIO to the touchscreen. Upon closer
> inspection, however, a footnote can be found that says "When VDDIO is
> left floating, the logic level is 1.8V [...]; when VDDIO is connected
> to AVDD, the logic level is AVDD.". Thus the VDDIO pin on the
> touchscreen IC is actually a selector and not a pin whre the mainboard
> would pass a reference voltage.
> 
> The fact that the touchscreen isn't supplied 1.8V by the mainboard
> means that when I originally submitted bindings for these touchscreens
> I only listed the 3.3V rail in the bindings. It can be noted that the
> original bindings and driver were added for sc7180-trogdor boards and
> these boards all use 3.3V IO via a level shifter on the mainboard.
> 
> It turns out that with sc7280-herobrine-evoker, we've got a bit of a
> strange monkey on our hands. Due to some very interesting but
> (unfortunately) set-in-stone hardware design, we are doing 1.8V IO to
> the touchscreen but we _also_ have some extra buffers on the mainboard
> that need to be powered up to make the IO lines work. After much
> pondering about this, it seems like the best way to handle this is to
> add an optional "mainboard-vddio" rail to the bindings that is used to
> power up the buffers. Specifically, the fact that the touchscreen
> datasheet documents that its IOs can be at a different voltage level
> than its main power rail means that there truly are two voltage rails
> associated with the touchscreen, even if we don't actually provide the
> IO rail to it. Thus it doesn't feel absurd for the DT node on the host
> to have a 1.8V rail to power up anything related to its 1.8V logic.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

We went over this with Doug offline, and after re-reading the spec sheet
this does make sense to me.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> 
>  .../devicetree/bindings/input/goodix,gt7375p.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index 1c191bc5a178..ce18d7dadae2 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -36,6 +36,13 @@ properties:
>    vdd-supply:
>      description: The 3.3V supply to the touchscreen.
>  
> +  mainboard-vddio-supply:
> +    description:
> +      The supply on the main board needed to power up IO signals going
> +      to the touchscreen. This supply need not go to the touchscreen
> +      itself as long as it allows the main board to make signals compatible
> +      with what the touchscreen is expecting for its IO rails.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 
Dmitry
