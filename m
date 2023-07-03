Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE2D7459A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGCKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGCKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2AE55;
        Mon,  3 Jul 2023 03:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A2A860EA5;
        Mon,  3 Jul 2023 10:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C48C433C9;
        Mon,  3 Jul 2023 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688378776;
        bh=fg9u5qol+i4IE9oNqt3vMUT6VtW9bdPHOEaHOZk3P+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nE02Uj7IjSAF3+TaZZKxSwCWOaQ/Ma2L2Eqp9+HVv2ub49lfF9UB8mhn1ftgsIGt2
         YmYmFl/Mc6tMTW/v3wpNxrzE0A7dlYmh1DtWST88uQ/lMrs+RbAUrbJkSNMSHvzc3E
         PeoHqM3CRVufm60o5/2l2LWrLohWcQk4sx49OR3JfAh7WogRlAU9QCcVPsb0k+pE8m
         JTsUWwz2w6vC0tgTsoQ+OirGd8Q26q53nahjZfFWiBzjR4E3TfdsC8e50mL6ystkiK
         D8+ibq/Iluf+I2LsoKQ3eRxXEIJkV3Yz9Mx5PpVdJpchWU5s5H/mITM0EowkbT55+o
         qfXsJCLQDOZ9Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGGRz-0000kv-1C;
        Mon, 03 Jul 2023 12:06:31 +0200
Date:   Mon, 3 Jul 2023 12:06:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Message-ID: <ZKKdp8r5Z_47iU-j@hovoldconsulting.com>
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
 <ZKKXGE95Sv-eLQa8@hovoldconsulting.com>
 <0f4f5a4d-379b-c00c-6bf2-58c08fcc4551@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4f5a4d-379b-c00c-6bf2-58c08fcc4551@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:56:40AM +0200, Konrad Dybcio wrote:
> On 3.07.2023 11:38, Johan Hovold wrote:
 
> > Konrad, please remember to trim irrelevant context from your replies
> > (e.g. so that we don't have to skim through thousands of lines to find
> > a single comment).
> My actual reply begins at line 77, which is considerably less than
> thousands and is concluded by my signoff, which signifies the end
> of the message.

That was not the point. The point is that you should trim your replies,
including context after your reply (sure, some people keep context when
providing reviewed-by tags, but generally replies should be trimmed).

Including an empty line before your inline comments would also make your
replies easier to read.

Johan
