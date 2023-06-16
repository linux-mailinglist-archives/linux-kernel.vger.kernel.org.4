Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F77335AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjFPQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345788AbjFPQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:15:03 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 09:14:40 PDT
Received: from mail.purtolebiz.com (mail.purtolebiz.com [38.242.205.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BD4495
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:14:40 -0700 (PDT)
Received: by mail.purtolebiz.com (Postfix, from userid 1001)
        id B1E39301B9D; Fri, 16 Jun 2023 10:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=purtolebiz.com;
        s=mail; t=1686902468;
        bh=kwwKurQZ1RuEG5hkiwOU//DQTAbymO8bblrpwhD4ihw=;
        h=Date:From:To:Subject:From;
        b=O06P9WaKVStqDkwnBWQXYl11KLjWZdBXErmpKnmgXC62uSM/qJjveY+jZ8Ctsl3nO
         mILAWUs2pL1TO5xK9rLfjQ4mnlwhaTjgnesRQWUd8/IW87aTB0737dNUZ+kLCSax8A
         6LN/1OCcTTweURPhIeqGTKH/RZe+R6IspVLtQVIcUVKOZQjOTSRMfXHRNEgD8RIUtF
         NIFQy/2LxAQOcxSUvbedLpOCS05ij0t5MZHlI7kJq69g8Hr9L1jwhiVOKhXH2TxYDg
         9BpqA8nRstSHiUClmKfv/4o3bSvmvSIEpbL3wOdKjhGIvC6GqyQ+P3ADvYMa0hrxoe
         pYAvOOfWTMsRw==
Received: by mail.purtolebiz.com for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:01:02 GMT
Message-ID: <20230616084500-0.1.72.137lc.0.ucf63lbdk4@purtolebiz.com>
Date:   Fri, 16 Jun 2023 08:01:02 GMT
From:   "Antonio Valverde" <antonio.valverde@purtolebiz.com>
To:     <linux-kernel@vger.kernel.org>
Subject: Consumo de combustible
X-Mailer: mail.purtolebiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: purtolebiz.com]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [38.242.205.154 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: purtolebiz.com]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0697]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: purtolebiz.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buenos dias

Le escribo sobre la gesti=C3=B3n de los autom=C3=B3viles de la empresa.

Gracias a las abundantes funcionalidades de la herramienta GPS, que monit=
orea cada autom=C3=B3vil de manera continua, puede registrar la posici=C3=
=B3n, el tiempo y el kilometraje de los autom=C3=B3viles en tiempo real.

Como resultado, los costos de mantenimiento de la flota de la compa=C3=B1=
=C3=ADa se reducen en un 20% y el tiempo de viaje o la planificaci=C3=B3n=
 de la entrega se reduce significativamente. 49 mil est=C3=A1n detr=C3=A1=
s del =C3=A9xito de nuestras soluciones. Empresas que cooperan con nosotr=
os.

Si el tema le parece interesante, cont=C3=A1ctame.


Atentamente,
Antonio Valverde
