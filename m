Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92903710474
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbjEYExU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjEYEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881B10C4;
        Wed, 24 May 2023 21:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7720964210;
        Thu, 25 May 2023 04:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66675C433D2;
        Thu, 25 May 2023 04:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990278;
        bh=YopTa2PPqJtJFvVkRJoVxMRjIdOdXsplv9Bdl2xEGzU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GiwrIwtfVxeIHI1j9UXjQqIlLXJKizbFcvI3AyqIvh4X3uDbSe/8hyGQv3OXvHKBf
         1OqVf4oq0oG5KA9N2kwDM+pSrRTQKYgTHdb6SZGpwz70UCSgAkr4bPPZUd2n4ODMLJ
         XUUUmYCeZKceLMHzvLojMzdTq7Yk9G3DjV4ZmkBRiVkQHq6IhJNH3KDsIFHh/Ezycj
         xH5RIH+rGm+DxEsy5U/tLKP/y5pKh3VbMnvM9KkjzqSZxO/3XvJIxvCh+NbtWDbzMR
         vBF5gRy/HKifDFoNtV4Lpnf8kY+msua+0GCQrep/IGQp5rYTC32iH5IHeSwn5efJYW
         qT17L1uvbpZtw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] MAINTAINERS: Add Konrad Dybcio as linux-arm-msm co-maintainer
Date:   Wed, 24 May 2023 21:53:59 -0700
Message-Id: <168499048186.3998961.11987026885802622578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522-topic-maintainers-v1-1-2b91eb8e4f65@linaro.org>
References: <20230522-topic-maintainers-v1-1-2b91eb8e4f65@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 23:23:39 +0200, Konrad Dybcio wrote:
> As discussed with Bjorn Andersson in private, step up to
> co-maintainership.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add Konrad Dybcio as linux-arm-msm co-maintainer
      commit: 2e43c85b0d96c6ae2ab60132313bb7a814bcfb44

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
