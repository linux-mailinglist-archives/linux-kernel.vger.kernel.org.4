Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13E96C14D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCTOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCTOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91B1A651;
        Mon, 20 Mar 2023 07:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE7126155F;
        Mon, 20 Mar 2023 14:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C70BC433EF;
        Mon, 20 Mar 2023 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322964;
        bh=xq2tMD+B7ia6JNh3O/9A7b/U2XKkAO4qVKedNe/qPK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOYhbdUn0Z+Lrg4yhdALBN5lZPnLW7Zu7MTUXbyKk8ywMf+RXwQ6WAqVGDsm8s2Kf
         Dus4RK7zmd+QMO1ri7UeoB9U0mfytcUVlNKHpAoEFEbAPYlcQ+O2UFu3QlgbGkEwjT
         TFPEsR79BVl6Q4qQZ0BmPvYjEUW4d2MgAJCyMAzPmJE20NwtfChcqKUEBBG7ORh6F3
         Ca3Eouma7zAU24FteDpe+Ht7JV2fOSpN5D++75cUg0oIQPt8XdDBf/qRSGwvAVjHhH
         RN5mkt4aLKwTM+rPAPwyxFoc25f9xp5mttO0RNttw+NyowUViBFqQ9RR3DVcduXLSf
         XJDIWPubNG1Gg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1peGdZ-0000mf-5E; Mon, 20 Mar 2023 15:37:25 +0100
Date:   Mon, 20 Mar 2023 15:37:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg'
 property
Message-ID: <ZBhvpXTZu/rwPvyt@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320135710.1989-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:57:09PM +0100, Johan Hovold wrote:
> The SPMI PMIC register region width is fixed and should not be encoded
> in the devicetree.
> 
> Fixes: 42f45cc655d0 ("arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram")

Bah, that should have been:

Fixes: d6dbbda37ab5 ("arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram")

Can you fix that up when applying, Bjorn?

Johan
