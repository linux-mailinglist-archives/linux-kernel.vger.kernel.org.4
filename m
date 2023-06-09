Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB197729B44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbjFINPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjFINPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8E3A8C;
        Fri,  9 Jun 2023 06:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB78C6580C;
        Fri,  9 Jun 2023 13:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7734C4339B;
        Fri,  9 Jun 2023 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686316525;
        bh=3aReAUG+DJc8B88pX0o1Gi0mPJY6ofGJi2dDLoLZTgI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GLi2NteF0ayvSDDxs0FRJBf2D4oi08eFqXvmyCU+GJ3qFfBk0L87Kt/cULLwhubvd
         Cx0UPNamQ5ipvlvbIDnO6Vt/KpSQvPJ8+nkt6C6ftq8BYmyHk5r/DN+swPZaI4UHNh
         cUYP6/G8qteGGM5jVI3vOLxNEcyIDLeuNTnXpSf+vi5hur/bCctJ2riQQK+7HTMcK5
         mXQxdyqLvNaCl+4u5NxElYKMmsvIeoHu1oCSpkkzIy/iUr5FNMAcBmspgF0p9vltql
         buP0sOn/kBUYpYzY4xhvZ2Nk5fJXqTqVKqBLQgEzo1AHbSFrdJNtt3ZwTF7t1Bcq1C
         vPIYYZPbnlu+A==
Message-ID: <8e676aa9-9e90-941d-489d-304b7c725904@kernel.org>
Date:   Fri, 9 Jun 2023 15:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: cpu: idle-states: Add
 idle-state-disabled property
Content-Language: en-US
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_mkshah@quicinc.com, devicetree@vger.kernel.org
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-3-quic_tnimkar@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230608085544.16211-3-quic_tnimkar@quicinc.com>
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

On 08/06/2023 10:55, Tushar Nimkar wrote:
> This change adds idle-state-disabled property using which certain or all
> idle-states can be kept disabled during boot-up. Once boot-up is completed
> same can be enabled using below command.
> 
> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disab

This is a duplicated patch. I already commented on other so to make it
clear: NAK for this one :)

Best regards,
Krzysztof

