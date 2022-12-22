Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB65423A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiLVN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:58:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECC13EBC;
        Thu, 22 Dec 2022 05:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 625D2B81D9F;
        Thu, 22 Dec 2022 13:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7EAC433EF;
        Thu, 22 Dec 2022 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671717516;
        bh=VbufY8V0lAYObd66/FPE+7EoTpkmX5wHxvxQuFIJvz0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hk+HOoDeu5y/BgeKnpm0uxAB+Babe83Uj57hR97nQx8oD+Udk4IoPGB3UDOBay1AC
         BQO8qUoSyHBxzLgCbJi/YcM3ppktBT44DtnHi7PcOk9HyMMir+x1aLky7zYDOBTBtU
         K5DiBgMRfu1IbLsDXcNuaDgGoku/RqMGRTaq7bB3zDfRUPykqzWwbk+Pk03PJFk2ko
         HrpoqeaA5wZ9eljplTO/8TCUPSfL5374qBSnxYWTkahs2o2dx5HgnxEx0WU11P6J4T
         8cJ8PMgQ8K3vVNm7z2NO63zFIRqmgoV9XiEX0acOjvkJNpU/ZoYS6JYF/DDv9rfj4f
         lUdQ3AR3eZYaQ==
Message-ID: <9d6bdf1e-7616-8f37-4f7f-eb45530b2742@kernel.org>
Date:   Thu, 22 Dec 2022 14:58:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/2] adds corstone500 device tree
Content-Language: en-US
To:     Emekcan Aras <emekcan.aras@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222123244.147238-1-emekcan.aras@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221222123244.147238-1-emekcan.aras@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 13:32, Emekcan Aras wrote:
> Adds device tree and correspondent binding for ARM Corstone500 reference 
> solution. 
> 
> Thanks for the comments, and sorry for the late reply. Most of the comments are
> addressed except one.
> 
> @Krzysztof Kozlowski: Thanks a lot for the comments. I've tried to fixed all of 
> them. Just have one question regarding having no dtsi or compatible platform.

You still CC wrong addresses - at least mine, which suggests you base
your work on some old kernel.

Don't.

Please base on newest master, newest maintainer's tree or linux-next.

> 

Best regards,
Krzysztof

