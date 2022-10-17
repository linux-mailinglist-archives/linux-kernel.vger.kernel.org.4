Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E88601B10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJQVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3844572;
        Mon, 17 Oct 2022 14:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EFC61261;
        Mon, 17 Oct 2022 21:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004E4C433D7;
        Mon, 17 Oct 2022 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666041091;
        bh=upMioIggewIXa2M22uJX8aWrajk9JfwdbOGuW7sizyk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XLZG6paU18vPHXNoOkrvAH5xxahz48xXg7CxWhkyO1Mc6NqGn0jsTJjeILNhuspP3
         JIkTi2NMSeDNsoTITn99I55qEPFIjACUxpfVP55BXhRhflYTZYpd8yJ0H+QY+u9Vx7
         vJwYA/bg3Uwb/saphjPBl1g/rocWGqGStvW8X70auehwc2iCIRomMKc0XaVh4HwS6B
         TUx4zOUKLpnHGGBTjMvkX4pbaz6CnevEL87XN5ZSSSnm99xZQvfYf0waE8qDKK0vbs
         Hmq0LdRB8j0CEUkB+O1crYqSTHxoZev+Ziy69JfrFdvP2k0r0rDUGJztLaeiI7FBAz
         qE5zxEz4tqmTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220913031756.983224-1-yangyingliang@huawei.com>
References: <20220913031756.983224-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/2] clk: qcom: apcs-msm8916: Use dev_err_probe() helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Oct 2022 14:11:29 -0700
User-Agent: alot/0.10
Message-Id: <20221017211131.004E4C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2022-09-12 20:17:55)
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
