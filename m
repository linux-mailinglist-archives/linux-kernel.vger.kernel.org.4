Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1456BCE34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCPLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCPLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43AB9509
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C5F61FDD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC52C433EF;
        Thu, 16 Mar 2023 11:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678966205;
        bh=bksuGUHa2p1kpCa3vL7h659pNiChOcNoM+Aeh3QRDaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GViO2ebD7Zu+nJJShfuDtL6XE/mESD2WGArVh+TYJSdOtgkcqOhqr8q+6dgd0bZQt
         bWhBNit8IRSMFL6s3dofnPIZolpgjm4tF0YBqyisRMAvso7DV5UWZ8FV/Ewch9Mtuu
         dCOnsJPYiBlwcjjeaYCNeb/nrakevcuLJDc/SKqyfBveatK9FYoREoqGeVBdTb6qC6
         EoHhaLR7Tws6F9eFM5lCzXKwk7Mm3CbDkMP0gtY3n6i4HlSnfH1255euWx/HUjMI5D
         /daSp45bWAkT08952h7gO6VGI1ebI143RlKJufYlsZ60/siS/HKj1hwRqGaqE3YFwB
         RaMfzF6Lt61zw==
Message-ID: <8e79e173-3f82-5995-fbc5-c6872f1e3cf3@kernel.org>
Date:   Thu, 16 Mar 2023 12:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for acbel
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     ylakshmi@yahoo.com
References: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
 <20230315174027.3540015-2-lakshmiy@us.ibm.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230315174027.3540015-2-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 18:40, Lakshmi Yadlapati wrote:
> Add a vendor prefix entry for acbel (https://www.acbel.com)
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++

I already reviewed this... please version your patches and provide
changelog.

Best regards,
Krzysztof

