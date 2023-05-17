Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12063705C18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEQAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjEQArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:47:55 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 17:47:50 PDT
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7634344AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:47:50 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 17 May 2023 09:17:48 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO ?10.178.36.63?) (10.178.36.63)
        by 156.147.1.125 with ESMTP; 17 May 2023 09:17:48 +0900
X-Original-SENDERIP: 10.178.36.63
X-Original-MAILFROM: chanho.min@lge.com
Subject: Re: Re: [PATCH] arm64: dts: lg: add missing cache properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Gunho <gunho.lee@lge.com>
References: <20230421223201.115439-1-krzysztof.kozlowski@linaro.org>
 <c9eda7f7-c397-4469-378d-de0d5ee379ad@linaro.org>
From:   Chanho Min <chanho.min@lge.com>
Cc:     Chanho Min <chanho.min@lge.com>
Message-ID: <2e45a496-ff90-d048-29b5-fabdebaa35ce@lge.com>
Date:   Wed, 17 May 2023 09:17:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9eda7f7-c397-4469-378d-de0d5ee379ad@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 01:31, Krzysztof Kozlowski wrote:
> On 22/04/2023 00:32, Krzysztof Kozlowski wrote:
>> As all level 2 and level 3 caches are unified, add required
>> cache-unified and cache-level properties to fix warnings like:
>>
>>    lg1312-ref.dtb: l2-cache0: 'cache-level' is a required property
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Please take the patch via sub-arch SoC tree.
> 
> Ping?

Acked-by: Chanho Min <chanho.min@lge.com>

Thanks,
Chanho

