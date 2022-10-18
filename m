Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9060223E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJRDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJRDJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C719AFDE;
        Mon, 17 Oct 2022 20:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E2661371;
        Tue, 18 Oct 2022 03:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BFCC43145;
        Tue, 18 Oct 2022 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062439;
        bh=zfF4bM8nnc6thuQugwRffQEkVgGKP5VGKQ6B75LA4UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbPX7jioi/joO7hYJktUoj32yXKxCoabnu56d61i96OehbjYcgSFlzSd9n83O8jGY
         MzC9LDdo63A3ixZC6/8OGIWk7CFfj+HBDbMfNqtEiUp9JqWiqhJnoXwrSMvIkAtNMf
         ZFkk0ZJbXbErR0gByVmNXY6YmEo5NKdwE3rvW0jPAXzvQwrvAp2SJTen8nmUpXEmtL
         PSbR5k7jjyx+bbufUc7hXcjdBH89Vw6BCDnQAN5tZlfXKIUkc0kZqyTj/6zvMpdmT8
         gRiq9mA2WMdrsTDDAbN0QXxfB4AoszOEvap4EeLXknKAH0QRrpC/oXsnaATeSPhUIY
         FVoFCKVKliVMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: remove bogus ufs_variant node
Date:   Mon, 17 Oct 2022 22:05:51 -0500
Message-Id: <166606235861.3553294.11527104728066067880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012215613.32054-1-luca@z3ntu.xyz>
References: <20221012215613.32054-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 23:56:13 +0200, Luca Weiss wrote:
> This ufs_variant node seems to be a remnant from downstream devicetree.
> 
> As it doesn't seem to be used by anything upstream, remove it from the
> dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996: remove bogus ufs_variant node
      commit: 54a8d54b51839df625d376eb8684e51ceec08629

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
