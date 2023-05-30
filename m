Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004147157B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjE3Hzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE3Hzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E6F7;
        Tue, 30 May 2023 00:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05C762349;
        Tue, 30 May 2023 07:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71025C433EF;
        Tue, 30 May 2023 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685433322;
        bh=8ZdTOa03jdrIEEMTRubaTPNotfGUbHnWuYuQN/xtOPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pZTF2iPEAyO8W9Utdy4WVirRx29yvcU1kmInYUI3eNQMllXS+VOlwBK05kE4cjMxm
         iT9hShvfgQRfHdzjKYv0DOEqATP1TAWzLwnevJEwSTONFyqhoUJow0AyIu9DOmiuf/
         FrofSDhfMRE4axz/VDizJeMojrALTfc8JO5H6NEBKIJww4JAw+HE/ifoy8w7RZ5XTM
         qav5qHfQL/LZqApbRShIy2S4xYnoc4V2YwhXkLIF31fE41+oJqdf61xZIYtkFz8Hj0
         sXAXTjeGZy7wLLDsAyg0GKY24Z1D/n5oKbLDtnqMHzs77yXpHvyuFYSMVMWsvwcj8N
         gusvJxpYikayw==
Message-ID: <43d8b745-ea0e-4359-8291-be750abab41a@kernel.org>
Date:   Tue, 30 May 2023 09:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: net: Add QCA2066 Bluetooth
Content-Language: en-US
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>
References: <20230518092719.11308-1-quic_tjiang@quicinc.com>
 <fb3678d67fd4428eaec98365288384ed@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fb3678d67fd4428eaec98365288384ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 09:49, Tim Jiang (QUIC) wrote:
> Hi krzk:
>   Could you help review this patch ?

Did you send it to me (as asked by get_maintainers.pl)?

> 
> Regards.
> Tim
> 
> 
> -----Original Message-----
> From: Tim Jiang (QUIC) <quic_tjiang@quicinc.com> 
> Sent: Thursday, May 18, 2023 5:27 PM
> To: krzk@kernel.org
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; Tim Jiang (QUIC) <quic_tjiang@quicinc.com>

I think not...

Best regards,
Krzysztof

