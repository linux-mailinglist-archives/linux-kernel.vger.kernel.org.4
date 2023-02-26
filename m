Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907956A2FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBZNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:17:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F2113F4;
        Sun, 26 Feb 2023 05:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 223B060C25;
        Sun, 26 Feb 2023 13:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985DDC433D2;
        Sun, 26 Feb 2023 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677417419;
        bh=Of+a0epo/ltgvupP7Y6hFvl1uyJBENPTgmCisbRck34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bbZuttuRXrwvICTzhNKLPnQ13SSNmX7xsC+RJSf27qf0mZmJqoHC+nevwKBgu0RDa
         I/izR7nWnQ2ItKHzZMzA/cPV9v/4kvfXohWPCf7PQgKZZNrnI6FsWKhMcpjTaSmv5V
         cBygcQxPzEGqwWbY3SNpjK0AEihrxmdIR8sLYeHdVSpy2tV4cnq2zKf8+9Ezgxn1+4
         QK6T6zPe17/3GKzOe+0DKbc4IW2qYSCRqcxgNcMXou1HXhVy17jv3w6Y+vaXjVH5XX
         egyLLgBSMe2eP/l7f0WNYQ8lAHgd3XXqwHx4dZ4EOF+LgfDOWIW0xsxnKvJblBFxrB
         //v4lRuAwvlFA==
Date:   Sun, 26 Feb 2023 13:31:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iio: pressure: bmp280: Add nvmem operations for
 BMP580
Message-ID: <20230226133123.2b96a82c@jic23-huawei>
In-Reply-To: <f3f453d9b2c0f7820ca9c56e24e2165b6c39bb67.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
        <f3f453d9b2c0f7820ca9c56e24e2165b6c39bb67.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2023 18:03:06 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> The pressure sensor BMP580 contains a non-volatile memory that stores
> trimming and configuration params. That memory provides an programmable
> user range of three 2-byte words.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Trivial missing static marking in here... Fixed up whilst applying.

Whole series applied to the togreg branch of iio.git. Not that will only be pushed
out as testing until after rc1 (on which I'll rebase it).

Thanks,

Jonathan
>  
> +const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
static

