Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0021B66A12D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAMRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjAMRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:51:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2074688A21;
        Fri, 13 Jan 2023 09:44:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C6E622C8;
        Fri, 13 Jan 2023 17:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E8FC433EF;
        Fri, 13 Jan 2023 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673631861;
        bh=/TvEdaQnixfTBRY60kd1Sqb49/Ul7/Ctq0AxWaiJKDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNLq1Swlnx3kKr+nR2rzwo+GXUG8Zp76/g2O+kc50d8VeyLm92uCYYIW1htMfB9Gb
         6x8VQ3IHqxI4vx9bWoW3MQVpMwJP/ii2A/hefduydZCAf0OqCocTJzPlm1DOj9BJsb
         dv6oniJ4DBtn8H2OWZXwSlOO/sJdyJbsxftU1BwMR3JNvUEVhMNcCg3RocbBlHY6bj
         qHZWRF4W34holfYLRYDR0UHuWg3uHQBHBz+y82P4lb8Kb94jmYg4q9vIUxWCqg06UZ
         qr7Pa23V9iJOWBYsRBEP2+OfhH4fSGmJTaqIDxCiQDWMyizkI7uO/uxmrqf48IIbIu
         zf3YkIGl4+QfA==
Date:   Fri, 13 Jan 2023 23:13:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-phy@lists.infradead.org, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org
Subject: Re: [PATCH 0/3] Add Qualcomm SM6115 and SM4250 USB3 PHY support
Message-ID: <Y8GYUWF/LHqGzlE/@matsya>
References: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-22, 17:58, Bhupesh Sharma wrote:
> The series adds support for USB3 PHY found on SM6115 and SM4250 SoCs.

Applied, thanks

-- 
~Vinod
