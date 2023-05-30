Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8203715E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjE3L5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjE3L5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DFE4F;
        Tue, 30 May 2023 04:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98E262E9B;
        Tue, 30 May 2023 11:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA45C433AC;
        Tue, 30 May 2023 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685447778;
        bh=KeOWYbGzBY6vsVhyFwQJbzeNpJ1yJW9UJp+AlHyUM4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KxfGhgSzSTG4M0ESseMtRydcsomhRiE3JIbU1OGrM17QfJcmsWCtomRLTgl/Ytj1b
         jFxplFqiRHFwszV2wH8grmmKzdccd6qUeBZ8vKPG4Glgp3SnwKYxnlfOLrVO/ce8eT
         9zXeNMswtHe4OV8TyYq7LGGhSuRUaIE7KAJogJEZX16H2FZptFLcNC/EaYEDjNgSV1
         cDIH1EDaYygPaP6517e6MfVZvoz4hKSB85xwwIJHSGmKt/LmDbpxK7uL+fAjpmgQ+w
         3PWLR98vtGFU+boagrlLLZbUxOidH7gnjHxsz4j0IEKlO3LnQ61t7gYM8exypWLP3C
         34oFGGlh/i+cQ==
Message-ID: <bd19f71b-59ee-80e7-9ff1-1cc26ecc49a7@kernel.org>
Date:   Tue, 30 May 2023 13:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v2 2/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
 <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 17:33, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 19, 2023 at 10:07 PM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>>
>> Add an ilitek touch screen chip ili9882t.
>>
>> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>> ---
>>  .../devicetree/bindings/input/elan,ekth6915.yaml         | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> I'm curious about the DT maintainers opinion here. Should this be a
> new bindings file, or should it be together in the elan file. If
> nothing else, I think the secondary voltage rail name is wrong. I took
> a quick peek at a datasheet I found and I don't even see a 3.3V rail
> going to the ili9882t. That makes it weird to reuse "vcc33-supply" for
> a second supply...

It's easier if they are CCed...

Best regards,
Krzysztof

