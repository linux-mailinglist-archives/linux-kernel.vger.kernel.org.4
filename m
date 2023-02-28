Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11A6A5822
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjB1Ld1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1LdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:33:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A359CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7239B80BD9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB9AC433EF;
        Tue, 28 Feb 2023 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677584000;
        bh=ySplhGjtRXHh02WU9pQEA4p/9BJOGHAH95H5Ub7YC/U=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=q+wxsQA16xJ7A1YNovnYV1avPzX/2o+XpXCx0EqjeANN6fNFEOR54lO2jrTbFa62f
         h1RLfsliUMz4xQZwJtibRfzvEONwCNGcCboWFNHz8plkHZmwpGZgfcRBSETIA45xoZ
         ROUqeGdCqIZugzOK0FS4m94BNEISvdgKYuNzLsw3Z8dNfjV+ojtwEg+i0Flt17EJjf
         RxGx3Tcikcry3Zwh26PHsDc2y3AUXwPxlORtThVEoSAdjSm/h+0+4uaoSj6cbywGB4
         jn6cZ8C2axBj+V1nFAwI8V5sGQfBV8yRWZ1KmP9gKoYpGRQ3Nqd/Bvv7YGI7CmszLm
         L61vQoeHWilng==
Message-ID: <f5238f9d-20aa-2cc1-8e83-820c46a33a52@kernel.org>
Date:   Tue, 28 Feb 2023 12:33:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] dt-bindings: net/dsa/: add brcm,bcm53134 as
 compatible flag
Content-Language: en-US
To:     Paul Geurts <paul.geurts@prodrive-technologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-3-paul.geurts@prodrive-technologies.com>
 <AM0PR02MB55242B90172EAB35D0ADF44EBDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <AM0PR02MB55242B90172EAB35D0ADF44EBDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 20:44, Paul Geurts wrote:
> The b53 Ethernet driver now has support for the BCM53134 device.
> This means the driver has a new compatible device, which is now also documented
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 1 +

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You literally skipped everyone...

Best regards,
Krzysztof

