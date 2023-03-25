Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6435C6C8DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCYLxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCYLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:53:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B2F1;
        Sat, 25 Mar 2023 04:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39424B803F8;
        Sat, 25 Mar 2023 11:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F31C433EF;
        Sat, 25 Mar 2023 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679745185;
        bh=FFBB5Qbytv/2GhipRMImzTvlxCw1uCSobBjuA0Yniqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iaCm8xHG0OLKDna6iEpAcJOZQ5gAYYo2lIHjr0T9zFwpCN+15+sEBDcSsvwSGlGil
         JKiQkOeBmRCCGdwyJTQJa1mbowpZrlm+6vdXUK8z/T2e2MqXvy/DuMEMweYsblZBjF
         UGGXTzK1GK/J5z5WYGXaWmPVUnnTy6GObPfZJKsy89R4A5xxke+Xyfd5zHZbTY9Co5
         Lzil0pPwVlwRyUcRFNRH28WtLcbIZLtpjflrntxjogojeUuqlwpWCnPfjSEFaBCCGI
         xOM2QvZ6KaTBgMmBqpMkFZqlT6+jHJ+IhMeXxndYGoa4ivUC3gNPDj0dkP7OTTYp0R
         0UGlzHMz3N56A==
Message-ID: <c6390182-8624-35c9-746b-f76e4987777c@kernel.org>
Date:   Sat, 25 Mar 2023 12:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] dt-bindings: Add doc for Xunlong OrangePi R1 Plus
 LTS
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>, Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325074022.9818-1-cnsztl@gmail.com>
 <20230325074022.9818-4-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230325074022.9818-4-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 08:40, Tianling Shen wrote:
> Add devicetree binding documentation for the
> Xunlong OrangePi R1 Plus LTS.


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

