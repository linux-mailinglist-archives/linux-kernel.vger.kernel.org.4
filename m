Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA4716809
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjE3Pwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjE3PwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:52:20 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 08:51:44 PDT
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3972126;
        Tue, 30 May 2023 08:51:44 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 58B031060165;
        Tue, 30 May 2023 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685461310;
        s=s1; d=bens.haus;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=nHusq5FOMaoHAZ9e8yY2B7qHbg2IjtZe79Ov+h+RHa8=;
        b=ay8nvqUStFL2kXlLJgaMXZ/50xthOwI5mME8AgRGOoc3Kt+ybZ43dHJ6zSSTjca1
        62R0E3H0gSy1V3dYcToqh+LHDWcQ1k188KU8+1spDXSruvLu+hlUl3/3gMLg4pOMJM0
        VFB8OVY0T8vgRhWx/O5Tvm2ctLwp0HCvcQZQYKTDNJop5d3XkXpVtCCWU0P0DWkyyzz
        Vv+3LfNmB/O8SuWXHh+/uDyH+ONmLN9/WByKji1e9mvZECfNA9alOe8cza/x5PopWx9
        VJtWsq77/7Fnlp0bo8KnNZ1YPF7mKhIY7TrdI7Lr751+ePxaatHopnufUsLMjdcwktr
        GQ8P+b+Bmw==
Date:   Tue, 30 May 2023 17:41:50 +0200 (CEST)
From:   Ben Schneider <ben@bens.haus>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <NWhH-xL--7-9@bens.haus>
In-Reply-To: <f8393f75-ff32-4450-b8d6-b08d43240200@lunn.ch>
References: <NWNpfIn--3-9@bens.haus> <f8393f75-ff32-4450-b8d6-b08d43240200@lunn.ch>
Subject: Re: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot
 failure
 and wifi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May 29, 2023, 16:07 by andrew@lunn.ch:

> Please Cc: the maintainers:
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Sorry! Maintainers cc'd.

Ben

