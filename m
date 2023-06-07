Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B537253AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjFGFtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFGFtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:49:15 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170B19AE;
        Tue,  6 Jun 2023 22:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686116940; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VEhMVBN9aGFLHIUsjkCJsAmmq1hY9LlcPi4NTs8QnIfFDUZLisyLHzQNndvt7Jcl2ZmE1UQbz5VMdOSJi5quXggtSp41ZJVrlTfxdT91XC1C6hY+RKy9MKh7lFbz502EBGGnzeDS+FS8KUr7RuMNHEC4dwZ582KVx/IfrGFCwy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686116940; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YpBVU4VdjXVaFIx6uMck+En94E4xCQfD1LgCcdAVBrw=; 
        b=kwjTJ16iJYmZ1a6+JLAohn4gDnmwePAOU6YKE7N/kGr2lXlyCG2MyISrk4qcqV9d3o9oFZh1tx1IFLBtB15st3/V44pQU4yEcSsYW0S918P6ywKSGHx1Z2UIL6+toZUGjGPjU2SyiYHoZfkP+/7uWx51w7xVuv5RCKPrL0LYRW8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686116940;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=YpBVU4VdjXVaFIx6uMck+En94E4xCQfD1LgCcdAVBrw=;
        b=WjzMwp+ZtzJ72eJ/4gDLuMKn/It8FqguADId912ytu50lJ36d8cVc6feSCqvk+Mw
        IkvriCMzmMLoXdkKTi+dxuRBnyvyxBCILdBSt5dzp643GgbPIG2OLq+DPf3TRB0lyU6
        UTnnTOdHEc8Yckgi9o02O3azlJ791s1j9k/yRphM=
Received: from [192.168.66.198] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 16861169387741020.6424216893087; Tue, 6 Jun 2023 22:48:58 -0700 (PDT)
Message-ID: <4e1f7a46-1a29-8c57-a61a-14088e0c9fdc@arinc9.com>
Date:   Wed, 7 Jun 2023 08:48:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606211600.1601694-1-liviu@dudau.co.uk>
 <20230606211600.1601694-3-liviu@dudau.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230606211600.1601694-3-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.06.2023 00:16, Liviu Dudau wrote:
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
> connected to the main SoC over PCIe.
> 
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
