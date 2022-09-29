Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2405EED71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiI2F7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiI2F7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:59:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB721B9;
        Wed, 28 Sep 2022 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NXUihHm0xOJUlsVS7RXSAPp6feiEX61IX5jpUCvHJSU=; b=OcpQjrOLrFI18JmVeNjMrL9A1R
        7tJ1vb91/D4zIehcuQeDcXBgWEWc9Xl+xmL5BKXwJO/AqA/okBi8EZrRVVvUxb/1Zr5iyXjBml9tc
        YbeJ8XmbynCK9wb8v/5M63FoBnnjKW4XC9q5a2OBI5uWqeJ/fUx+0oN2qsJpTN7EhxMVSsGrC6xMC
        3X6pSYDb7hAkiTSJSu8KW30+9B0q31u03Mhj8cdkCTX649Naya6CuUGoYpjQxOhm3is6F2spQh+GQ
        445tRdvylO9aKMliyOLsUycg1wqMdsxlOo4IrzkvrL56/Dk500SXnQRNW3xk4vcSTbo320eV3zJvB
        k3QT6HxA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odma5-001K2m-0M; Thu, 29 Sep 2022 05:59:33 +0000
Message-ID: <d0c824e3-11fb-6002-982d-c15916f060d8@infradead.org>
Date:   Wed, 28 Sep 2022 22:59:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Tree for Sep 28 (Kconfig: SND_SOC_QDSP6)
Content-Language: en-US
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220928192605.247546-1-broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220928192605.247546-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 12:26, broonie@kernel.org wrote:
> Hi all,
> 
> Changes since 20220927:
> 

on x86_64, when QCOM_APR is not set and COMPILE_TEST=y:

WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=n] && COMMON_CLK [=y]
  Selected by [y]:
  - SND_SOC_SC8280XP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && (QCOM_APR [=n] || COMPILE_TEST [=y]) && SOUNDWIRE [=y] && COMMON_CLK [=y]



-- 
~Randy
