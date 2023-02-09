Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7F68FE91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBIEZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBIEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14C3C23;
        Wed,  8 Feb 2023 20:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A211461888;
        Thu,  9 Feb 2023 04:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D806C433D2;
        Thu,  9 Feb 2023 04:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916486;
        bh=ewl8IV5ttwBvAg3PgKSUvPl5tKVH6XXn0mdz74rZAl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biMhVQyE+hVHq8EfxU1hIa7sdeDoV6wAQNkEPdAX9rmTezgAPZlkEBUZKHkmlBH2w
         7wff1LMFQXiEziew7xbBB50jKbPRcHeaqihwJPK8sIUPpaUBF0trhobV4r0X3VlLFN
         OpjCqToHNqQHJH/FT5XrFyRhZyummwjBdEQlcWqI9J70mH9VrOFMzUSEUdWkVxiOX/
         amiiS8Mu3vP7+lHtx11EAXdYBS5SU+1hWQiYqOvhWh475TsJfgWQKETuOxlu9F2j1O
         2HTRuM6lxs9/f6pkupbusmb9vmBgO8EZUQG6A3cN+SaRwbVQuROyTKxDAyVF+UeZ4M
         uSAVvhxZj+qMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next] dt-bindings: clock: qcom,sa8775p-gcc: add the power-domains property
Date:   Wed,  8 Feb 2023 20:22:44 -0800
Message-Id: <167591660368.1230100.18342647248733584263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130145154.195562-1-brgl@bgdev.pl>
References: <20230130145154.195562-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 15:51:54 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The binding document is missing the power-domains property. Add it and
> update the example.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,sa8775p-gcc: add the power-domains property
      commit: 1519c0a9ab90a239c52d8a6d3e7ef78537868496

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
