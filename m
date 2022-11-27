Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89281639C27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiK0SBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 13:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0SA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:00:58 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DA2641;
        Sun, 27 Nov 2022 10:00:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so8053066pga.1;
        Sun, 27 Nov 2022 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:content-description
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=erOSLBSJOQriWz/l6knkBLN238RYB9gG07xwp8IgsdQ=;
        b=OvcKHZx1bOPL4vhRYfpP5DpL891tNTyCxcE6407jvN5ZdBPi6NR0Vmys+7wJGnoZ8S
         hAXrZPPIKrozox+tvXh2/c3sY7eV+WcnN6b0v6QodxPy3erT2Lk48djJqStaHkdGdvOb
         2s7s4stoz6hp5my0ooBVRKdZFMGj3O9mI9IqKT/z+9atfUun3xTAdiV3ZZAwqUCWsQ5H
         I2jxiZDWNxIyXMuAeXDXzgwMDCpEru5Z9Wtn14vbQBXgOjybmQxJZna5Aa6S44FTbpS5
         IC9BCY35d9+aoLk5ryeESEt24oAeOa/km4F9sALTmvh5hppacY+kVG4n3/1a7tStj9Bl
         OpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:content-description
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erOSLBSJOQriWz/l6knkBLN238RYB9gG07xwp8IgsdQ=;
        b=Djqybbt0mo8YuM/01PcbDKPzarLnrq2mRiqDsLrBgqi8jxEdZONXQrBij7jcfFcM2Z
         TzXnFoV6c34q9hz/nzoqOjomFJqzOL39aXCAOUQT7MEBPNYc0o+BllcbEDk0ofup0fxO
         k7nfDn3lFBmkfFhzl81MfLGxLVCNS2eRcpOmHCeaJ/PDkNs2tbei8+mVY5/+llKh/wEW
         Hfs7gtdm5gbs3hfWVlsEbVsEQzNA6a5gjQSIr2hCJey8nFEbSWC7/muxRCFvz8ITqsMR
         uaXTbv3adrQGtb4GuVu4yvTXuKjB2Y8/wHS+eqWwbKgNAyfOiHltbdZzOHuzlXV7Uv1T
         9vZg==
X-Gm-Message-State: ANoB5pkqGB3wdCYBOEFzN8bL/HXtSqK8CarPlYnbwSPe7sxgeScrNxp0
        PMc4I9MGxEZp88Ye6dF7Bfo=
X-Google-Smtp-Source: AA0mqf6VD8hOT83036nEo9FhNPZMJYSEBoHzW6/PU2nivJh8sLHdQdHY/Sg0PJ+9xNcqbN3/0GYMSw==
X-Received: by 2002:a63:5a48:0:b0:45f:88b2:1766 with SMTP id k8-20020a635a48000000b0045f88b21766mr23914138pgm.357.1669572055769;
        Sun, 27 Nov 2022 10:00:55 -0800 (PST)
Received: from Mahakal ([2401:4900:1cc4:c66e:6c75:d2b8:130e:c9e5])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0056b3c863950sm6416443pfm.8.2022.11.27.10.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 10:00:55 -0800 (PST)
Date:   Sun, 27 Nov 2022 23:30:49 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com, Mintu Patel <mintupatel89@gmail.com>
Subject: Re: [PATCH v3] Common clock: To list active consumers of clocks
Message-ID: <20221127180048.GA8763@Mahakal>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
 <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
 <20220822235014.86203C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: Re: [PATCH v5] Common clock: To list active consumers of clocks
Content-Disposition: inline
In-Reply-To: <20220822235014.86203C433D6@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
As per your suggestions, we have updated and sent another gerrit with
message Id <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
In this new patch we are listing the clock consumers name along with
consumer id in clk_summary.

example:
cat /sys/kernel/debug/clk/clk_summary
                      enable  prepare  protect
                             		                             duty  hardware                                Connection
clock               count    count    count  rate   accuracy phase  cycle    enable       consumer                         Id
------------------------------------------------------------------------------------------------------------------------------
clk_mcasp0_fixed       0        0        0   24576000     0     0   50000     Y            deviceless                   of_clk_get_from_provider   
			                                                                   deviceless                   no_connection_id   
  clk_mcasp0           0        0        0   24576000     0     0   50000     N              simple-audio-card,cpu        deviceless
											     no_connection_id   	  no_connection_id

Please review the latest patch.

New patch details:

Message ID: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
Subject:	[PATCH v5] Common clock: To list active consumers of clocks

Regards,
Vishal


