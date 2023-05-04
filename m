Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F46F6CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjEDNPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:15:10 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1B6194
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:15:09 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 4 May 2023 14:14:33 +0200
MIME-Version: 1.0
Date:   Thu, 04 May 2023 14:14:33 +0200
From:   m.brock@vanmierlo.com
To:     "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc:     Rob Herring <robh@kernel.org>, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>, manion05gk@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
In-Reply-To: <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
 <20230427164351.GA3146210-robh@kernel.org>
 <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
Message-ID: <4f59ac40e5dabab01560888782f7ea0d@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guntupalli, Manikanta wrote 2023-05-02 12:14:
>> > +  txrx-gpios:
>> > +    description: Optional GPIO to switch transmit and receive modes via
>> pmod.
>> 
>> What's pmod?
> Pmod is galvanically-isolated RS-485/RS-422 transceivers with a
> built-in isolated DC-DC converter, that eliminates the need for a
> separate isolated power supply in space constrained isolated designs.

AFAIK Pmod is an open standard connector by Digilent and present on many 
Xilinx
demo boards. It does not involve any galvanic isolation.
https://digilent.com/reference/_media/reference/pmod/pmod-interface-specification-1_3_1.pdf

The ISOW14x2 on the particular board you're using does however give 
isolation.
But you cannot name that board Pmod.

Maarten

