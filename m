Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE596142A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKABIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKABIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:08:35 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3433167CC;
        Mon, 31 Oct 2022 18:08:33 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13bd19c3b68so15320643fac.7;
        Mon, 31 Oct 2022 18:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkVZqxjemZWhoVabZk5YcbL3H9P5S1HNJrfIuS+Jm2Q=;
        b=DPS6/8/GpGlIYZRwAo8w8ABq20QsNVUw03TKiTUWPjXYOWCoEWFwY3KEITSEAGOdPx
         +FdEUZGQVZtQFApSMTQDjkZFvRAxcWN212K4NpINkEiRODelqX8VY38AY+T3TPmnepgi
         QLW2bZyMQ2yUgJ+oGjTmr8U2FgCmSGHP7dLjV5rcl7Rhrh5YxSllZ4h0fp4k6Crak0jX
         1/l2UhtP/l43k7tkL8RhY9PQIzveMCWqKKzE912rXf1dLtK3PmOJ/+hQwui7cMoKgWv6
         57jnQJKPy0PaX+/PxKYdPp2+c0Gw5Cu7sbNy8go3eR8fIjkeECai6aY7w8ZzZYYDDkIA
         XKDw==
X-Gm-Message-State: ACrzQf0ezFKJ3DT7kyzEu9+hfwkSpJr0Z+Sx2kjtUcmbPCKMhf1myUKq
        D2wrwWvwcW1gaMCUtbJCqvMaStFJeQ==
X-Google-Smtp-Source: AMsMyM5s/TLtNmTf6pyI0/TB4FnK1lstOfBUqUGcVIlbjL/cr2l0qlAgnrdhOoeXpc4AiV6ipkm/fA==
X-Received: by 2002:a05:6870:4390:b0:13d:2be6:dac with SMTP id r16-20020a056870439000b0013d2be60dacmr1435983oah.3.1667264912818;
        Mon, 31 Oct 2022 18:08:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj23-20020a056808199700b00353ef11d6c9sm2912777oib.19.2022.10.31.18.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:08:32 -0700 (PDT)
Received: (nullmailer pid 4035896 invoked by uid 1000);
        Tue, 01 Nov 2022 01:08:34 -0000
Date:   Mon, 31 Oct 2022 20:08:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [RFC PATCH 1/2] dt-bindings: adc-joystick: add valid-range
Message-ID: <20221101010834.GA4034975-robh@kernel.org>
References: <20221031190159.1341027-1-lis8215@gmail.com>
 <20221031190159.1341027-2-lis8215@gmail.com>
 <166725358721.3638147.11464755727689545438.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166725358721.3638147.11464755727689545438.robh@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:05:54PM -0500, Rob Herring wrote:
> 
> On Mon, 31 Oct 2022 22:01:58 +0300, Siarhei Volkau wrote:
> > The valid-range property aims to cover detachable/lock-able
> > joysticks where measured value goes outside valid-range.
> > 
> > Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> > ---
> >  .../bindings/input/adc-joystick.yaml          | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/input/adc-joystick.example.dts:82.28-104.11: ERROR (duplicate_label): /example-1/joystick: Duplicate label 'joystick' on /example-1/joystick and /example-0/adc-joystick
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/input/adc-joystick.example.dtb] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2

The examples aren't completely independent, so you can't use the same 
labels.

Rob

