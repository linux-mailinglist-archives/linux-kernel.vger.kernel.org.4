Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C969B86D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRHA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 02:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:00:55 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAF2CFC9;
        Fri, 17 Feb 2023 23:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676703627; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ibn/e0SI9GQh4lDLBhxqdlonSElsEuFMrplZzm3M/PffVKWad+sAvv+NUK1+YEjCyqE/+UW3K4R1ZIYlHW62TSvJ3bliQWSuLQm8nnMDvhwTe3yb67rn4/CceEg0BtAkXF4e+Bmxe6Gqt34BQam7Uqz48XJiffQTge0mPiE67S8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676703627; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=m/+NU3Tk03Wf0ez3AouViIcqSIg7JKhumDA5hc0v7rI=; 
        b=AVAke2H7pJiYPOxLOOMh/x2vc00xvWnUWifJTj72x6JwVXv2JogcbVfMkQHigQ1ejWaO69rt7dQPDn+OqSZPLSGwxKEP+Y9PzhmPdtubph1c3ayr7tlcC0mewRhKLXvr76PwVNfUKEg+fauOY6bR5cGKFAd9FlEncwOw0JHOyG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676703627;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=m/+NU3Tk03Wf0ez3AouViIcqSIg7JKhumDA5hc0v7rI=;
        b=WS8aq3V/y75+JmBMJQbdrCOF7ESRzQjdb2LOiBU8iACugWUvW6k2tbmMI3ajHr5O
        Gw59JbBcWkggLNHoF6iuIoxZgQUiHdjNZtPRALFLEP2nbxGxZHUstl1gfpC6peYWxy1
        PhUmmRYM0RAlykVskLKodL0MUbv0uAA6ntIkGgAA=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676703625115619.8764980966916; Fri, 17 Feb 2023 23:00:25 -0800 (PST)
Message-ID: <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
Date:   Sat, 18 Feb 2023 10:00:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs, mt7530 switch,
 and add port@5
To:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank, I think Matthias is waiting for your approval on this patch 
series. Is this series fine by you?

Arınç
