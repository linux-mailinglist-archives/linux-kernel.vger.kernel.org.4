Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABF7364E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFTHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjFTHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069911716;
        Tue, 20 Jun 2023 00:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22346103B;
        Tue, 20 Jun 2023 07:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E76C433C8;
        Tue, 20 Jun 2023 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687246577;
        bh=Iw+s7u/KTHMceoFYllQq6Cj60DTWYwWM+CTQBzHhnB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ec1x6xmKX7/rC5TC3NR5xJt7R67jd0RQhN5MNrg6fQ4DJ5puMrcxmHE9t3ultLgWI
         JuCEd1eXKd3pxGq6JevM9dRCdynwh325QPGAdGkSCISIcSC4yf+PbVNJfaPE4YmiQo
         pAXDhfS/Yzn8AQWU+WYKzz0dYLgZ7GQN+Y4GYe+4=
Date:   Tue, 20 Jun 2023 09:36:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
Message-ID: <2023062004-sterile-exhaust-35b6@gregkh>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
> Add the nodes to set value for DSB edge control and DSB edge
> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
> resgisters to configure edge control. DSB edge detection control
> 00: Rising edge detection
> 01: Falling edge detection
> 10: Rising and falling edge detection (toggle detection)
> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
> configure mask. Eight 32 bit registers providing DSB interface
> edge detection mask control.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>

Your subject line is missing a prefix :(
