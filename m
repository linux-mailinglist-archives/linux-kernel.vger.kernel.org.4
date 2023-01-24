Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56DA67969D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjAXL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjAXL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:29:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410E2CC74;
        Tue, 24 Jan 2023 03:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D984AB8117A;
        Tue, 24 Jan 2023 11:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E994FC4339B;
        Tue, 24 Jan 2023 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674559787;
        bh=K6WhJx32HOAhLucQVv0jSk8TaQu1Hz44D32MMzWfv6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZDZyjO8THnye25danif89e2Bf3ZrD88eBpK/eK0zUDPHdRtJaQEO+ENRWVfA2tomx
         ieu//Lj7nwqhe1HEnZ7YGlYbr2OR2yd4ITIpWWMhPuPKyxWNN6/sjsDVcOz174Se8G
         0ltGkpQeBywWv7ntZbGG9zYmMS1kPcau2fDQRGwUGLRYE3/WdnBb9hgRz5OloXxdsn
         xtynHFOmVldk15WX1QGf0H85umvp1QVMXkChGuWQb9AUywzl2us3wWLK3BtCPFnxM9
         GELyjlDP7ixhiGCvsAJRA0Re9iUCftcOPp+pgnUyIzoGeIREMZcPjPou2kms90lmvj
         GEO6jAEBYoYbw==
Message-ID: <907da24c-1619-a75b-b6b6-66c8ae86df6d@kernel.org>
Date:   Tue, 24 Jan 2023 12:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3 v6] input: pwm-beeper: add feature to set volume level
Content-Language: en-US
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
References: <Y8+8824hy/fWkpEk@mt.com> <Y8+9WRP51u+dof8p@mt.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y8+9WRP51u+dof8p@mt.com>
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

On 24/01/2023 12:13, Manuel Traut wrote:
> This patch adds the documentation for the devicetree bindings to set
> the volume levels.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

One more:

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Best regards,
Krzysztof

