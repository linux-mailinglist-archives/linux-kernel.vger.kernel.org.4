Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2016A66DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCAEGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAEGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:06:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D230416AC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:05:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A25B61213;
        Wed,  1 Mar 2023 04:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEDFC433D2;
        Wed,  1 Mar 2023 04:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677643558;
        bh=kvrhyaw0pMFZ14SqdZTC1ePR7GaJGC0/AjRxQCixZ6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGLvMhyAFIbkJcDU+kIsBphCSRKe+y5phM3MqIWbTrM1HHGXcwfLlIO9kPYZuG0Qc
         6E/TlS/9TiwQ1ctXQc0Bup1nHGTQT5J21mQkTtBiuK+HNhpADXzlp77BrfPwP8+KaP
         PaBBT2JQFc6HfXCzTLmCPbH92gwzdVOpwp0DekQk4U0efOWhyl762IiQvHqaVfmr1i
         CmcJdvNV3LqeFJP/JHOlrmCofOAWq1gvhfAnXEeFtmzzLUnQaIG93x2Tnk8pUXHkDz
         H/gVXCo8O5RhS1JDB+PKmAEUOrMYvWjNTwXX5rY1NpNwc7gSvIVNjSl6H//ZJmitY7
         NP1KqigBnfaDQ==
Date:   Tue, 28 Feb 2023 20:05:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Yanchao Yang (=?UTF-8?B?5p2o5b2m6LaF?=)" <Yanchao.Yang@mediatek.com>
Cc:     "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "Chris Feng (=?UTF-8?B?5Yav?= =?UTF-8?B?5L+d5p6X?=)" 
        <Chris.Feng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mingliang Xu (=?UTF-8?B?5b6Q5piO5Lqu?=)" <mingliang.xu@mediatek.com>,
        "Min Dong ( =?UTF-8?B?6JGj5pWP?=)" <min.dong@mediatek.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@intel.com" <m.chetan.kumar@intel.com>,
        "Liang Lu (=?UTF-8?B?5ZCV5Lqu?=)" <liang.lu@mediatek.com>,
        "Haijun Liu (=?UTF-8?B?5YiY5rW35Yab?=)" <haijun.liu@mediatek.com>,
        "Haozhe Chang (=?UTF-8?B?5bi45rWp5ZOy?=)" <Haozhe.Chang@mediatek.com>,
        "Hua Yang (=?UTF-8?B?5p2o5Y2O?=)" <Hua.Yang@mediatek.com>,
        "Xiayu.Zhang@medi" <Xiayu.Zhang@medi>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Message-ID: <20230228200557.1a563b0a@kernel.org>
In-Reply-To: <3e38940908752018bda7912f294d7a7c390657b7.camel@mediatek.com>
References: <20230211083732.193650-1-yanchao.yang@mediatek.com>
        <20230211083732.193650-2-yanchao.yang@mediatek.com>
        <20230214202229.50d07b89@kernel.org>
        <2e518c17bf54298a2108de75fcd35aaf2b3397d3.camel@mediatek.com>
        <d6f13d66a5ab0224f2ae424a0645d4cf29c2752b.camel@mediatek.com>
        <20230224115052.5bdcc54d@kernel.org>
        <e7628b89847adda7d8302db91d48b3ff62245f43.camel@mediatek.com>
        <20230227110047.224909ee@kernel.org>
        <ebe8c4057b16c6565223af53bfb229dd1846d26b.camel@mediatek.com>
        <20230228103132.325def4c@kernel.org>
        <3e38940908752018bda7912f294d7a7c390657b7.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 03:35:05 +0000 Yanchao Yang (=E6=9D=A8=E5=BD=A6=E8=B6=85=
) wrote:
> BTW, the patches are reviewed one by one (patch1, patch2, =E2=80=A6.), or=
 are
> controlled by reviewers (there is no obvious order for reviewing the
> patch)?

They are reviewed one by one.
