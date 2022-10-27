Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEF610104
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiJ0TAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiJ0TAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:00:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93A2C124;
        Thu, 27 Oct 2022 12:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E21B8276C;
        Thu, 27 Oct 2022 19:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D665C43140;
        Thu, 27 Oct 2022 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666897206;
        bh=jTRZROpVRFgHBN4u+4jUGfrpxPdbf35GT5C+bBuJNeo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BksIoMvgAA5GK7y9smkc4J9RxQEcg9SwSm4IF+0EuqjV7KT06Eob3NFffPcsQ860L
         Kh6RPT5rYSi5bqXFjZduN9upRWoOOCQdOqekl3htQzanogVH4D6h2TYPzcCrWltNVX
         2+1R5m4QqR0V+EnzcI97l5/imtxEsnVaPAQMHN+qxtVYJV3vvlWLsxty08y8qsY3Ss
         kQWuAXibbYZfVBoOUp/guveF8YaIVD7j1D1+HELts6zrvRIjm/OLMb5B6WyP+7hNZL
         BQoX4rrnozJg2YdLDbGk8b8tHBkfN49E8ViirzpYkSQ2iJYFZ1I3R9MXFf/cXZk8Ut
         TZXIR5iFdovIg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026194345.243007-7-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com> <20221026194345.243007-7-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 6/6] clk: ingenic: Minor cosmetic fixups for X1000
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        paul@crapouillou.net, robh+dt@kernel.org
Date:   Thu, 27 Oct 2022 12:00:04 -0700
User-Agent: alot/0.10
Message-Id: <20221027190006.5D665C43140@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-10-26 12:43:45)
> Remove redundant -1 entries from the parents array and fix
> a couple indentation / whitespace issues.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Applied to clk-next
