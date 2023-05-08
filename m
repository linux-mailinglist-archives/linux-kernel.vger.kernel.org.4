Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC56FA665
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjEHKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjEHKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D3D04D;
        Mon,  8 May 2023 03:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58C06250A;
        Mon,  8 May 2023 10:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757EEC4339B;
        Mon,  8 May 2023 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683541131;
        bh=9KY1PeJl8oSwQTG6pnGtV+8TzHjeyBSQPgNFwcFBj1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aESE56QxrwheagOLjsp8MaUrP4FCHtu07cjol8JCg+6Z4MxCNPW6z8Tb5+g5KkfR5
         kdyyHglqIcU7C5F7pdszqlIeprTkq2OIDz6XygbjlUWbARVElnmAa6xtx7nftZkZSt
         jpzU/RfonVZU1WUuSbVdCx/wsW5N6I9ofWM48fdyHoTs/VgsDFMb3w28hvdlxUXHe6
         Puuu3mEcgWOHXsX/fN/GRt6G9XHElte2SmatydCos3oPHuCdqOXsyUVeLGRmyZGD1l
         5S47jXJNF+/0o+6pzyWKYHXVrv0Rwsf/frW/N4YAT4o1gNSHV9CF8B3eN4pJPruTUq
         ZYOmz4fQWQJlA==
Date:   Mon, 8 May 2023 15:48:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: qcom,edp-phy: allow power-domains
Message-ID: <ZFjMhmcAK9G9no+0@matsya>
References: <20230416151233.346336-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416151233.346336-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-23, 17:12, Krzysztof Kozlowski wrote:
> At least on SC8280XP the eDP PHY is part of power domain:
> 
>   sc8280xp-crd.dtb: phy@220c2a00: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

Applied, thanks

-- 
~Vinod
