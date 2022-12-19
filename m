Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5566A650A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLSKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiLSKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:50:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC15BC00;
        Mon, 19 Dec 2022 02:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD2F60EB7;
        Mon, 19 Dec 2022 10:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12548C433EF;
        Mon, 19 Dec 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671446998;
        bh=A3VkKPICWqmqnDaWN0cKcYEdoV07F+Y6/PeP1lQP3B4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TEXyOCFTTwkxGfxtAbp/Mky8Ihs6chDpXarV+fDWm7JW56Oz2H5Be0do4XSZpYFCB
         N4oyRGf+QnQTUXlhB1jgmSW+Ewodhxod/O/7lF4DHf/ux71cg5LdEWiIPV3bz2VaO0
         6qbUAzHMsFfkATUo5ihy1XCnX+gBTKFRH3/Z/jQkZlCGxCRib7u1Hwmome5ep6CByo
         KSI1ojmlld3LriUmjyZe0yfcszlHTdvEDfnJVgFK03ZEeEz5T2rmZxPZ9DvOX1XVN3
         oqO9DxcHwh71ucs0pjMBcnl4zWYBrmRHjCfaPIriJ4Mi8bvtKxBOLqF05vIsnlLSum
         K/3QDUPn2VDGQ==
Message-ID: <f39cd52f-94d4-fe3b-a5be-8b27017028ed@kernel.org>
Date:   Mon, 19 Dec 2022 11:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt: bindings: add dt entry for XO calibration support
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214121818.12928-1-quic_youghand@quicinc.com>
 <20221214121818.12928-2-quic_youghand@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221214121818.12928-2-quic_youghand@quicinc.com>
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

On 14/12/2022 13:18, Youghandhar Chintala wrote:
> Add dt binding to get XO calibration data support for Wi-Fi RF clock.
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You skipped all of them, so this has to be fixed.

Best regards,
Krzysztof

