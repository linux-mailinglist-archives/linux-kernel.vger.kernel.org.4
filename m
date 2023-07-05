Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32385748973
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGEQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:47:20 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 09:47:18 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBF10C3;
        Wed,  5 Jul 2023 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wcPRR4CqUAZ/m80TOLg7mrR9VzFvX30Kf7EKwxfW274=; b=NF4MgRQk9Gdh8tb2t7BsaQ4F0N
        J6VlmKTyFrNQ+5VhlYxAZuLv2STcuLbvH4j/ISbjGXdqCZNp0JRM7DjCWTDbtmyvjOTATwhCUWKhM
        DHtBZABEvqZ00j0s0jRALmJefSmM88B9CNz5FlQK3zp5/ZDzC727+9Uz1a9VoLg73F+vzh7WXig3i
        Khl1yTmTXDmlmkuA5YRo45A1pp529wGEuG3EC+aVls/BTO8ptXfBCKT1jqUaqEtDA/CdgUzQVrYBk
        U3MT3RuEGDz6jgog48EiGtMsyrXl9GYkIGqONkR155KZHqoeRGWtSebljtMck6dSbeMiBIW86jWH1
        2fhX06Vw==;
Received: from ip98-183-112-42.ok.ok.cox.net ([98.183.112.42]:56616 helo=[192.168.0.142])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <david@lechnology.com>)
        id 1qH5H6-00056J-2U;
        Wed, 05 Jul 2023 12:22:49 -0400
Message-ID: <161958d9-d84a-9e55-7878-7774b51dec7e@lechnology.com>
Date:   Wed, 5 Jul 2023 11:22:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ARM: dts: ti: add missing space before {
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 9:57 AM, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


