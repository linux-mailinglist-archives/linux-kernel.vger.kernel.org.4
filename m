Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E75710503
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjEYE5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbjEYEzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93619BC;
        Wed, 24 May 2023 21:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD980642D0;
        Thu, 25 May 2023 04:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D186C433EF;
        Thu, 25 May 2023 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990326;
        bh=+T/NEleBbodkGdBELfX6j5V5nV6NrftPcqzrjA4fZbg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XvIsdGTz2ACgQxJ8m8dKmXCh0j6rmI8EMMIO80DvcAMq67BuQooUfyMRbmXbrJ1D1
         miDMKT7LV1hMkXOIYtkJgIxauXdsfC5uiUAdCmFGhrGOhPB4MAmS7mHL04ShcbNhWa
         13gJR/AMjH9O2JjgJB5+2Gu8iGIuCXQ5FJ59vpt4vHQ70bZDTQ+lBBxbAv9A+3So4Z
         eeV4IkdMzgRzZvIZF3r828ch7pNY8mc7PuvDer7S40K7X8fjkzK2NOYO/bK01/F8sb
         bS7jX1Q0Bk6APE195AJU6GQzKhJS+mym2rVBeunZlqH8UW3R5X9VRhtqfblk8EmIbE
         9aRcfixGUR98A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Add QUP5 SPI node
Date:   Wed, 24 May 2023 21:54:43 -0700
Message-Id: <168499048180.3998961.8475474543724082975.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426185647.180166-1-robimarko@gmail.com>
References: <20230426185647.180166-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 20:56:47 +0200, Robert Marko wrote:
> Add node to support the QUP5 SPI controller inside of IPQ8074.
> Some devices use this bus in order to manage external switches.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: Add QUP5 SPI node
      commit: cb0c14dae63fae037db41174fc95a59dea0ecf77

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
