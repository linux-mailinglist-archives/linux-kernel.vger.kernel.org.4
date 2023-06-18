Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9C7344C0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFRDLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 23:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFRDLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 23:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2A4E62;
        Sat, 17 Jun 2023 20:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E647160B6D;
        Sun, 18 Jun 2023 03:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC1C433C8;
        Sun, 18 Jun 2023 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687057861;
        bh=QfJGGmVPtzH2/wtuC9y7Mu4NQbqbm41TJrsmBMBHqYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=adNlcTOIQdffWMYX4FWuZIbY9HuYoiAGLyr3ozcML06ju56PtAa02qK7CF6eAGh8D
         fR5wRi7si6Ut9H/DbAx9CdPSYN+mXyy4qSAyKLy8XGk2k67sedXzxmcem7XRKrpLJZ
         N/mEo8O9XrCe82Yhr5p8lOAZD5JymNFhzC4nrA2+zjTq7cGjnu92lmwAk1Q1gtM1lI
         4LUE8K0VeWg+83PFioWOo9ZO3sCvz7E9ADF9u1O8D4MA0gQGf6FdxwNTPfjoKCngG7
         99awsLy54uyU4QMXg4uteI/Mw1p2bvqzXhNG9iROJ9d0QwyzXb0BuFcWbyjnHcnaSZ
         pzKjwR8WkJC3w==
Message-ID: <fa42c1ad-c411-2121-92f7-fc1e1f0f8172@kernel.org>
Date:   Sun, 18 Jun 2023 12:10:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: rk3588: add SATA support
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
 <20230612171337.74576-6-sebastian.reichel@collabora.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612171337.74576-6-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 02:13, Sebastian Reichel wrote:
> Add all three SATA IP blocks to the RK3588 DT.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This patch does not apply to libata for-6.5 branch. What is it based on ?

-- 
Damien Le Moal
Western Digital Research

