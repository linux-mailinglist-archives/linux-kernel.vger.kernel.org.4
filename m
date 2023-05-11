Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF856FF383
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjEKOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjEKOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:00:33 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619732D5B;
        Thu, 11 May 2023 07:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683813593; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=chZYxiLztGDfjMD2pYB/zEfdBEONq+lFYC/Ft6eqc8HHd+U6MgVh6L3IPY2dbg8IJBss8+zD/bGfRcWb3Vfq4X9lFh2E5dZMlWBTU3Oh3Vrd8TcGSSs2AZcOwTmWKdp0jA3qWnBpcjfXnnoztFQnOh86J2vuYS7x8b4wQ/dMYoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683813593; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qQbMYUDsKNLkUWpHaNQP5KTAN9kqwWBsuvO7Tkmxnrg=; 
        b=B3EB078KwObMionflVutgZsfg4L2poFyHMtHGebE/oWqg9P7tbqkb2yUCLOU7lDPvjyjjSg5a+f7sGt4tACbNP9HHDoTwAJOegbPXwPGOdPSI2hGwy9Otbbk8/UVJGHb7WKuDFNAI6IHmvP+R1pJqS1V4yKU/R0sEh7j89E72h8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683813593;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qQbMYUDsKNLkUWpHaNQP5KTAN9kqwWBsuvO7Tkmxnrg=;
        b=jyDGGe7HtEGOUSpSq1PJKv5c2Q0d/wUjSTqkEQb9YH6/GKG1RKzK+Nq3v3cteu99
        d4LaGj8vmsvGiyP/JzHvxxhWkoKbghBoy+L9Z9MEhlvyUfZYTG4JInviGxSDOzJSNQA
        yibzJ0ZxTmetCXyRSikmJRM0A3o+TvrXLey3Z6LE=
Received: from [10.1.111.147] (185.242.250.116-ip.operadors.cat [185.242.250.116]) by mx.zohomail.com
        with SMTPS id 16838135904591003.9773108387027; Thu, 11 May 2023 06:59:50 -0700 (PDT)
Message-ID: <b6050e71-7ebe-ff3e-5683-b60ce9327c58@arinc9.com>
Date:   Thu, 11 May 2023 15:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mips: dts: ralink: Add support for TP-Link HC220 G5 v1
 board.
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230509200125.309026-1-liviu@dudau.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230509200125.309026-1-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please remove the dot from the subject. Also check the patches with 
scripts/checkpatch.pl. At least one of them has got 80 columns on a 
line, the limit is 75.

Arınç
