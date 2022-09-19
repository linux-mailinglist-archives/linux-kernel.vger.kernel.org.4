Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855255BCCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiISNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiISNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:17:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C927CCF;
        Mon, 19 Sep 2022 06:17:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y5so3926244wrh.3;
        Mon, 19 Sep 2022 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=JQnXUuOJXq/53Yv1BXw4BU5ty1+Q8lF8nWyvKAwQnVk=;
        b=djAwBlz4IYY0rUhhPbPSWE5HYq9S/iI4r09rzmHuXTKMoHBZMEbHVraoH+31PHYC8W
         PaI/qr4jI1tuIYiX1rsMt6zZdteqBWUbeY3RFJyCDsmRoojctjj6aWgWtG+eU3zNfJ/j
         4HtGVnaYijO5BQSDfHs5bRDpBwD0vKSK36ElNPTndJE7sRjJS6t+SHMySFr2/HV+nL2H
         h8EG24wZj0tfl/hWpfNNnglczOVpb9DH/iPHBqOvQ8fV5rrg43c6K5lNUD4mentn42qM
         D9Zue07KaQgYuofW/9kXCvBGBqaeyX+/X+lwPzyJnQgoFyb2UvttuEAlWFZ8ekNqIUD3
         k3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JQnXUuOJXq/53Yv1BXw4BU5ty1+Q8lF8nWyvKAwQnVk=;
        b=T31GtAK8gUSq9nHSGxbk1yyoPQMYpF3u8cmZEk1KypGpkCGXi3DkALr/wKG590ILEP
         LFb8HUGPl2I3F75ONSQaaaBKRpPEHfTFk6t/Q9wYrQy0l16eOGJykkAhJPrX5cj7Z9y8
         zUym8w5fZRS67dppZ7T/WauYE770coayD/sVeUWKvAxIFz8b8wegxAym40kXK8fLt2CA
         qfAYnV6DPurp8qw+AhTaWxlC7AfvuNLAIHd38+7rg/Q5VlUPPvXQ04uriPLqEs/SGr2W
         9PkoLtKRANE9Emuuz+J4ZRzgwg9+9gCV1gyDqCiVZBq7iaJ2keK2B49JBU4ot0Iavbp3
         ILeA==
X-Gm-Message-State: ACrzQf0tx+BwMndwZBDe+ce8ucEf3at3Qs11HrL7RU2PoDDH3rpaQitm
        lmftxbgHART1ZdEMcP4AO2c=
X-Google-Smtp-Source: AMsMyM6At6wZZKE3giXauF/PxG0cXvEkzICAJxueaR/qWjhvyI9oPNaCyMGvp6xsR2W7eU60d1x3ug==
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id r15-20020a5d6c6f000000b0022a77786ea2mr11104709wrz.15.1663593431937;
        Mon, 19 Sep 2022 06:17:11 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003a6125562e1sm14346610wmq.46.2022.09.19.06.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:17:11 -0700 (PDT)
Date:   Mon, 19 Sep 2022 14:17:09 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220919 due to 3f74cd046fbe ("ata:
 libahci_platform: Parse ports-implemented property in resources getter")
Message-ID: <Yyhr1VW3Kn30E/Jv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of arm allmodconfig have failed to build next-20220919
with the error:

drivers/ata/ahci_st.c: In function 'st_ahci_probe':
drivers/ata/ahci_st.c:147:24: error: unused variable 'dev' [-Werror=unused-variable]
  147 |         struct device *dev = &pdev->dev;
      |                        ^~~


git bisect pointed to 3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in resources getter")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip

