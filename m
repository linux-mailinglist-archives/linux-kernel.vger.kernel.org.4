Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23EA73EF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFZXh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC4198C;
        Mon, 26 Jun 2023 16:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9D460FA2;
        Mon, 26 Jun 2023 23:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5FAC433C8;
        Mon, 26 Jun 2023 23:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687822676;
        bh=dCvEa859LMiQOvn6mEPWv5OgRaX7eSzUYcM3MW1DbeI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fHtYxX5UO2gqwaZ1/JNCP30rB36bmv2b8prf8lcQDc44gsy35gS+gpJZ+4908cKIX
         PzBq1kD38jPPhzpSI8uLm6YsLKXDn/xF4cgU+gN4MrKNa0GRPJj1gYJLtoGeP3NR6q
         YU2SAKMX9MThLoYoxm1rqPF9grBOkZp4W1FGq4BJgbGSD/hOI2eA809CI+Fp9o5B0V
         kbUFKgxPT4ANAVjDbPFkaviYhx3TqxIab2CL0HXR8i0Q1LGwP9Rs8B/fqx9HcdLZ2t
         kIw+10tLMvDRP0EhVtFaDqAhbBGzV4xZxYV4QxI0s3+/QWHNjBYF/4D4zdKhv/0MmY
         DdeUM9hb4CHTQ==
Message-ID: <9a24013e1a0124d85a8c663afdbbaf3f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230623201519.194269-1-afd@ti.com>
References: <20230623201519.194269-1-afd@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Remove syscon from example
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
To:     Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Jun 2023 16:37:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Davis (2023-06-23 13:15:19)
> The binding for ti,am654-ehrpwm-tbclk was updated to remove the syscon
> compatible hint. Remove the same from the example in this binding.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied to clk-next
