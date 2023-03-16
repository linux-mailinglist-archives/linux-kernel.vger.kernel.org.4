Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA26BD490
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCPP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjCPP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201736C6A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C17DAB8227C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B26DC433D2;
        Thu, 16 Mar 2023 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982368;
        bh=SpHYw01fBJ3nF32f43qZ4/WwYFpX/uEb9i78oEQ5lhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JK4u7ZXcNm441dbdlBWNuU32ZNYXtttVh9SP57UhYaGIl40cM5JjCm59RueEys1q4
         IXEHTccNyOLc+YRPbXpo9WEqAdfjXq3Us16IGJQiA4Nb4GTaHepIJqwITWdi79H5SN
         mjhutjfZKSEe0eHsCZIhJ+fXawv9SgIs7HAsPQsy70J2dKs4G+jN4E08u2yZe7NnA7
         XQA96hhwlG7QgIf0DRujcFYOB1lu/7oV05o0V+FShOSaKX1E2RTc+63YpcYIWKWrP1
         dE0gkbrMc45ezqWSrOFgcRFe30+gcINyfko2mapMHnbC2WLHLiYHtMkUxY6gIWC/GG
         y210wGriM9Yqg==
Date:   Thu, 16 Mar 2023 15:59:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] mfd: atc260x-i2c: drop of_match_ptr for ID table
Message-ID: <20230316155923.GP9667@google.com>
References: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
 <20230311111629.251830-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111629.251830-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Krzysztof Kozlowski wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/mfd/atc260x-i2c.c:44:34: error: ‘atc260x_i2c_of_match’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mfd/atc260x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
