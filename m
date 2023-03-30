Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918AC6D05A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjC3NBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3NBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:01:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D40E44B8;
        Thu, 30 Mar 2023 06:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32500B828BE;
        Thu, 30 Mar 2023 13:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B762C433D2;
        Thu, 30 Mar 2023 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680181270;
        bh=2xH63X6ch0GT/Dr1bWEuVMA2kF2W/9nwmcWahPFft6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdPjnkFHVs6D3MwYM0HOfAjmstMh1oztarQVPx1mRfP/jCKStl68aOf1BALf35HAH
         IBtf0v6YgpjggDkim3mfTvvGOZUALXya13k36HtlBSwXSdGA176MJ43aretOpZ0Zan
         J6Aeuxnm8B7xd5Nga0mkdLe7l54SEAOllBsrseqgCzuWrOuFA1GkNNES+OAMz7H/7Z
         6hSSZg+6sOLwbneATjSW+Tc4b4PwxLEB+GXyIGE50dR0ZrymM4OIA2nDunxiFQpX2l
         BDiiCWsvFK06WKa/QL3mKj8+XHu68AU0ckbrDk8Dxq9+7fPnizjlw3S9SfNvy4PQjv
         sslDenIXvJMng==
Date:   Thu, 30 Mar 2023 14:01:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_c_skakit@quicinc.com
Subject: Re: [PATCH 0/3] Add support for high resolution PWMs
Message-ID: <20230330130105.GO434339@google.com>
References: <20230316192134.26436-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230316192134.26436-1-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023, Anjelique Melendez wrote:

> Certain PMICs have a high reolution PWM module which can support from 8-bit
> to 15-bit PWM. This change series adds support for those PMICs. Thanks!
>
> Anjelique Melendez (3):
>   dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
>   leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
>   leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM
>
>  .../bindings/leds/leds-qcom-lpg.yaml          |   1 +
>  drivers/leds/rgb/leds-qcom-lpg.c              | 151 +++++++++++++-----
>  2 files changed, 110 insertions(+), 42 deletions(-)

I guess you'll be fixing the build issues and resubmitting?

Please retrain the Acks you've collected.

--
Lee Jones [李琼斯]
