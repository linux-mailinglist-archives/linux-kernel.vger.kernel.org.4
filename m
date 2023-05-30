Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF6715280
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjE3AMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3AMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65389D2;
        Mon, 29 May 2023 17:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0AAB62911;
        Tue, 30 May 2023 00:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB88C433EF;
        Tue, 30 May 2023 00:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685405558;
        bh=5nnc/xve3txZvnGeXvtuJbHv/rAFYkFBRCZNo3lum0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhkERC8gyT+QADhjHHtme6n+hHfohb5uaxkVM4H/VHkbQmA5BaFTRvMoFWW8AbKtu
         MuXigU5YQsuOepF2hWk2qOLpk9M0Hf6mvC31N5AJQgwZlG+xE4u884+ZG+59HUpsEN
         ht7jezmdD4VqQYYaSRJTDALrxeVglsCzhAqom/wuXZ2raXTYo8FUP5O+1WJLzB2kcc
         kVZS4Gkj0ArHQWAIhi7IcFxZvoBZjBM+auHl7u+QDFi99Cs5lfXseV5X180giuOxw2
         s1orFeIearjBgfazhGNdIFyrt+crA0lcSfPC+6tNXITopZX8VyXBaMW2XHcqGd10ZZ
         NFmevGReBj95Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] soc: qcom: ocmem: Add OCMEM hardware version print
Date:   Mon, 29 May 2023 17:16:22 -0700
Message-Id: <168540577537.2201922.14315010265492564569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz>
References: <20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 10:41:15 +0200, Luca Weiss wrote:
> It might be useful to know what hardware version of the OCMEM block the
> SoC contains. Add a debug print for that.
> 
> 

Applied, thanks!

[1/1] soc: qcom: ocmem: Add OCMEM hardware version print
      commit: e81a16e77259294cd4ff0a9c1fbe5aa0e311a47d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
