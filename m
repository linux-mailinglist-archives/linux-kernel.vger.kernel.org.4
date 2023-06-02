Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9534720042
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjFBLS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjFBLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:18:44 -0400
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736318C;
        Fri,  2 Jun 2023 04:18:31 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:c9a:3200:0:0:0:1])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 352BHn9O1185756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 12:17:51 +0100
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.15.2/8.15.2) with ESMTPSA id 352BHhKM3898766
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 13:17:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1685704664; bh=D25jkR/WUH8PZduU3b5o10N3jWWeZOgQA2nLbFQTGnA=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=G4jFD+3B1qqEeWsYZVROqK3W7y9sWFjgHXl792FH3ygWbvhib4HhcUOehbsFOlCwf
         SAhOUYFpgfmNmjli1/X9VwqJ3e1nbRxOC402OQ378spDK113DnswOSg3UY54wkOrl6
         NrH8TylEUzIt795lkdcfmgK35SarfxXHrmRIUsKM=
Received: (nullmailer pid 1385861 invoked by uid 1000);
        Fri, 02 Jun 2023 11:17:38 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Wes Huang <wes155076@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wes Huang <wes.huang@moxa.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] net: usb: qmi_wwan: add support for Compal RXM-G1
Organization: m
References: <20230602054112.2299565-1-wes.huang@moxa.com>
Date:   Fri, 02 Jun 2023 13:17:38 +0200
In-Reply-To: <20230602054112.2299565-1-wes.huang@moxa.com> (Wes Huang's
        message of "Fri, 2 Jun 2023 13:41:12 +0800")
Message-ID: <87y1l2m7u5.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at canardo
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wes Huang <wes155076@gmail.com> writes:

> Add support for Compal RXM-G1 which is based on Qualcomm SDX55 chip.

Patch looks good to me, but checkpatch warns about mismatch between From
(which ends up as Author) and your SoB:

 WARNING: From:/Signed-off-by: email address mismatch: 'From: Wes Huang <we=
s155076@gmail.com>' !=3D 'Signed-off-by: Wes Huang <wes.huang@moxa.com>'

If you have to send this from a different account, then you can work
around that issue by adding "From: Wes Huang <wes.huang@moxa.com>" as
the first line of the email body, followed by a single blank line.

git will then use the second From as Author, and it will match the SoB.

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>


Bj=C3=B8rn
