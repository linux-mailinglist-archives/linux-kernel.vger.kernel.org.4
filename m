Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F946E05D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDMERY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDMEQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DAB9752
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBE5633DE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0BAC433EF;
        Thu, 13 Apr 2023 04:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681359227;
        bh=OOtiEl1s8kkwvIvHWmrkiUGnWkCyB/qLpaMGpmw4kyo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VEOX7oGmkWfjL6fMgdFJr/WISqXYhR++l8/XJO1jDwIYa1WArTzfYdYpGqFWK6RFm
         Mrl0xrpwQwFe/k8BIGvlZ6JZsxKAAp7jQHuxfd6iLmVVA2Tat7nTX1egtNjB6me2Sx
         GI7Od+gM928AREpgjejFiR8MZcXckok1bB9iV5hPKQjkcyTncBYaXTObiImz5iDNqr
         kd9sqX8FkqLlpSGlODnP8x8KuccMcda/s6UDuZfuZLO7zsfLZb5ZCUYi2K8tGHjY1h
         YgF2O6qR873Ajo/loCes1UyOi+oUm8f7MzyDJXqXAI0mBvCr1h0pRNLtvSjMj6gqgJ
         MfU4myVbck+qA==
Message-ID: <196935840760ba54cb4237c63027713b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230113064040.26801-1-rdunlap@infradead.org>
References: <20230113064040.26801-1-rdunlap@infradead.org>
Subject: Re: [PATCH] spmi: fix W=1 kernel-doc warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Wed, 12 Apr 2023 21:13:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2023-01-12 22:40:40)
> Fix all W=3D1 kernel-doc warnings in drivers/spmi/:
>=20
> drivers/spmi/spmi.c:414: warning: expecting prototype for spmi_controller=
_alloc(). Prototype was for spmi_device_alloc() instead
> drivers/spmi/spmi.c:592: warning: expecting prototype for spmi_driver_reg=
ister(). Prototype was for __spmi_driver_register() instead
> drivers/spmi/spmi.c:592: warning: Function parameter or member 'owner' no=
t described in '__spmi_driver_register'
> drivers/spmi/spmi-pmic-arb.c:155: warning: cannot understand function pro=
totype: 'struct spmi_pmic_arb '
> drivers/spmi/spmi-pmic-arb.c:203: warning: cannot understand function pro=
totype: 'struct pmic_arb_ver_ops '
> drivers/spmi/spmi-pmic-arb.c:219: warning: expecting prototype for struct=
 pmic_arb_ver. Prototype was for struct pmic_arb_ver_ops instead
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to spmi-next
