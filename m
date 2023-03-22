Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609E6C5AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVXkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCVXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:40:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832102366A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528413; x=1711064413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OGHCWQte3YjhGFJqMvAzpeC0UB5PdXMpxYWRoLzMsDk=;
  b=b4uSGKMOmTqTnEGtl0X91FWlL5aa00WVW9n4jkeUx1lgQv5w9adMhWNL
   HF+aoNYwVXG3VsVGor8tjV3DVpmAI0gnBqGoypcHW2uFiiMgj1STVITth
   FjYoDSmq/7C4qGYwEqmRBw38K+d+CUpNukHR1nqKS1CsfPBrQjrJF5k/E
   QhLgQZrOlzDSJrZUGn87x5ZKEMQiqphkc0IFxOzFN0ixA/uxKkyzz9Ebs
   9V7fnUDF4kpmELtxCmJT7kwOEP9XktO5hpBnI/f8WzwCe5xGgFkTa9Ln1
   aCsEJrcJ3MnuhV/2/rF1PblrZxwI44sbIdEaC7QjDkTjCYqOi3Hr4uWnk
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="338331053"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:39:06 +0800
IronPort-SDR: NYLy/dbvpq60qIJ0dQaZYgYJWkg3zyu3pOZmfauGGagXi0zdAXB1mkadaD926L6g6KlAJCuBEl
 1yMQMkDUvsRo/4rGeNgtmWltEBZDybhg7uQqjc0vPcLfNx9+XPtPa6s50stqw0FmQ7UTlsS8gn
 YzlyKiWcGZLebXpiS6tlqSrXDqbLJ39SdHnWptagOO1PV4JysTQ5s7jvcuLPUHIrIQ1py9aXYk
 Lynr6l+sVPzSThfZ6fs5Rg8V7Rd22iV8BFm9PLgQt+j0aTpYxt69qwuHpxdZKJcWkvUr51aU5a
 /1Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:49:42 -0700
IronPort-SDR: QmiznkWGrfIVRjayuL2RaUOoOdPtP2LjJY0ZOc2gzH0eL0QhguE9nzCVB/Dbs/ir3INYiJMJLx
 NcYI7l0451VyViBoown28MGX/CG8kiBQGAAyLl32gmHN0Sd6+tYAsJMXuYx+VMi+4Nbsibtq3A
 vEiNDQ385hT15cefroz5/oQgCi/3KN6nSl/Rx5LlOauHNqEcSvN6XxOtI3E0NLLpPLsjAXDsMJ
 nivhrJcmhKPc+Cwf9vkM41mH+2xiGhA+f9yN0ClnA8YUvfxII2s4A2bfuvdfo0oi64omdmyEAr
 67E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:39:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlL210dmz1RtW1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:39:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528345; x=1682120346; bh=OGHCWQte3YjhGFJqMvAzpeC0UB5PdXMpxYW
        RoLzMsDk=; b=h9QS/6X7fJDm4CcTVHlExM/CvxKaQSHcJ3sMvlNeQIXATYROTa4
        ZSV+nLM79WCXq1AXsi8715n3y057dj2zZBTZOrGPgj9jkm1supLwusYWL+/prSZI
        mKf+YP1brVHXyAphtOar6qqhijH9KBR8i//9QjNisAvDcoaP8ZHx8+MfDD9yRlIq
        7KpzNJXuedKjhXsnAneHlHuEBq9aiR4Sv2avbjMPEZ/pxQHfL1Fnjv8S9jzQgYjO
        SRyztT4rEec+ORnjWXzFsMgcTgY8DXePtzO0bcTkiIX3hTkZboWSqZmd94itO88t
        SY88AkV3V1JB+53ucoVW86pRXi57DYvMVbQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xpeACEzXwxYr for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:39:05 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlKy5gVBz1RtVm;
        Wed, 22 Mar 2023 16:39:02 -0700 (PDT)
Message-ID: <1f963db6-5404-e483-69ac-fe8eaf5bb478@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:39:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: mfd: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
References: <20230322173519.3971434-1-robh@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322173519.3971434-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 02:35, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

