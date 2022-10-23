Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377C609305
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJWMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJWMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC161B03;
        Sun, 23 Oct 2022 05:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88FD60A4B;
        Sun, 23 Oct 2022 12:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B1FC433C1;
        Sun, 23 Oct 2022 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666529640;
        bh=aX1WrsOsTPAXPfHbM7Ad/YlFXeHjpIr6vYxaHrD0BQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+slejHiPFNXtpc1Ard5wW503+UVWhvAOUh2+KadPcJ0a6QQ6XrBNdUmD8MnmPC7h
         WT6iYp88RAwG+0IqmIlfWBvHOD0LlUPt+lL/h9GL5iFvLnjVTfMs1/ZifbKPM+g3jr
         JsWa99AtESjLwCWQJR4h/OP+2jJTdvt+Z1xam/bs1o1S1WlhXW13qx4jfosWH7vegY
         bFjE/zQVWB44Vcqtj+ZpgLVXelYGbYKpsK/im4ccFgMsopDxf13VY3FnD0VIVJRNBq
         StiFJSjKjZhqB8VzU3Y4bOGzEtZWeP731Md2dngsLwIH3QuVJUjGmdT3Mn1NeVx/dZ
         /892EqE3ChUGA==
Date:   Sun, 23 Oct 2022 13:54:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 5/5] iio: temperature: ltc2983: support more parts
Message-ID: <20221023135435.17cf55e3@jic23-huawei>
In-Reply-To: <20221020090257.1717053-6-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-6-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:02:57 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Add support for the following parts:
>  * LTC2984
>  * LTC2986
>  * LTM2985
> 
> The LTC2984 is a variant of the LTC2983 with EEPROM.
> The LTC2986 is a variant of the LTC2983 with only 10 channels,
> EEPROM and support for active analog temperature sensors.
> The LTM2985 is software-compatible with the LTC2986.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
LGTM. I'll pick this up once the DT binding part is resolved.

Thanks,

Jonathan
