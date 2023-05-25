Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9852B710B96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbjEYMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbjEYMAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BABE7;
        Thu, 25 May 2023 05:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 200AD63163;
        Thu, 25 May 2023 12:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0CBC433D2;
        Thu, 25 May 2023 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685016038;
        bh=UZTlDfi4bEdRqD3JDM7L3ZRvVfkiRMW5k0IPD/z4eNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlwG3hmic6u/yOAwqznwUTOLSeNUVNfAppJMXdOAy/k231evK34D1ziGK/9/CyLhV
         uNEk5CcIGZWAWDAvDZKqZdR3Fi6hwQzsk1N3ZCvPaCv1GMsfnpXJdzQWlVa3PuDmf4
         H7LwJl6cvlfTdMw9rFmNPI4lZYq1XNUubQlPQgC3aDd1bg21FaxFEXXwE+eRmbYm/i
         F1XsUdKq3sVSMwcXeVTAq6bDDQFMraCNL+JZXjCyidC+DRvy4veNrdND0husQH8dbu
         H9HuawrSh0ZZ2h2V4Vb4E0PqvPLebGwpGyWaMKq2kx4tqck5mS3grcSX7b9Z7JmSoS
         /aIAZcw6cmo9Q==
Date:   Thu, 25 May 2023 13:00:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: leds: qcom-lpg: document PM8550
 compatible
Message-ID: <20230525120033.GA443478@google.com>
References: <20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Neil Armstrong wrote:

> The PM8550 PWM modules are compatible with the PM8350c PWM modules,
> document the PM8350c PWM compatible as fallback for the PM8550 PWM.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Rebased on for-leds-next
> - Link to v1: https://lore.kernel.org/r/20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org
> ---
>  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 31 +++++++++++++---------
>  1 file changed, 18 insertions(+), 13 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
