Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048AA620ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiKHIGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiKHIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:06:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41396155
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:06:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v1so19617012wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLTnPx6da3QZnsmw8M3iEUc58DPj68tgnowR0uRDzPA=;
        b=CQbU0E04QErWDwPIkCetXS0Jm3MMs5TDhIxzybauyEV/ZJTSypnHVfcHekbIDd3Ug4
         HqyYZoK+CCyK1ZjDkKLI1rMFrhqy4YSM3r2d5sd2Tywv3X3ni7n4B36Qm5LS3fJbQiov
         7ovB1oLQ5KZRHmXB4dfHDp2V8KNCudB8qpQzAGxqEKECzdqPfuCPG0Be66Z3wVf30Dlu
         pxeZu8PiWxzIoAX5x/aHoTW1LtIfBwi0pFOSyhFydHnRL+5rxA0vsWgyg1xROpFpHLjO
         o+2VLX+3cIsxwc/uGFMx2aoTv13RM4EdD2Z8XUdhvZGKpDjpyCE8AmoKCtjI47Adhax/
         Ooag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLTnPx6da3QZnsmw8M3iEUc58DPj68tgnowR0uRDzPA=;
        b=IBfBxCcUsMuv5STJZ6PJrSfA5SGIIWjbHS/cB0vGY71kbSMGWk3uysDjjcfD9yhePN
         7csBGQAe1/6yLYYweSITcTTwQv+LhIBXCBxSzTeUhtNVxEZgPwbQpE55JjEZDlxvmwCS
         In/1Gr++fvQ2sEjyhnuhbNbBgxSDYw6cpBVM4zjbvLMyYMILAjzF2a379gOnA0bEu5uZ
         Gqxz3dJdSoBr2KFV6aRJ/UTs7srVEDO8tRD6cO8QwRl2yCnsh6cY7KlY3EHLfqcvrM/A
         hd6brxJHglolxa7JBltBq1QIYuQQKqaa5iHHPlp7PJ2vxAQXiWuINhT7Ch7PsIeI4YFq
         bXiQ==
X-Gm-Message-State: ACrzQf1/Cd8oeS+/uQwtycGPradsO/miiwJhYLqMEFfeJlFY9pc/TniS
        /YI4W5qUFx3cPh9CnGgdcmI=
X-Google-Smtp-Source: AMsMyM74uB74BxTOCbgup4aDnjaHn1GDidiUgobkkwJLHUf6liqttwyCRNWFvu7v4VLuQm0e1GlyoA==
X-Received: by 2002:adf:f04e:0:b0:236:5d8d:8a1e with SMTP id t14-20020adff04e000000b002365d8d8a1emr34514018wro.392.1667894791994;
        Tue, 08 Nov 2022 00:06:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b003c6b9749505sm12340613wmq.30.2022.11.08.00.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:06:31 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:06:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-tegra210-quad.c:1160 tegra_qspi_combined_seq_xfer()
 warn: iterator used outside loop: 'xfer'
Message-ID: <202211082115.oCcR0547-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59f2f4b8a757412fce372f6d0767bdb55da127a8
commit: 8777dd9dff4020bba66654ec92e4b0ab6367ad30 spi: tegra210-quad: Fix combined sequence
config: arc-randconfig-m031-20221107
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/spi/spi-tegra210-quad.c:1160 tegra_qspi_combined_seq_xfer() warn: iterator used outside loop: 'xfer'

vim +/xfer +1160 drivers/spi/spi-tegra210-quad.c

1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1046  static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1047  					struct spi_message *msg)
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1048  {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1049  	bool is_first_msg = true;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1050  	struct spi_transfer *xfer;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1051  	struct spi_device *spi = msg->spi;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1052  	u8 transfer_phase = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1053  	u32 cmd1 = 0, dma_ctl = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1054  	int ret = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1055  	u32 address_value = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1056  	u32 cmd_config = 0, addr_config = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1057  	u8 cmd_value = 0, val = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1058  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1059  	/* Enable Combined sequence mode */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1060  	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1061  	val |= QSPI_CMB_SEQ_EN;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1062  	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1063  	/* Process individual transfer list */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1064  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {

When you exit the loop without hitting a break then the "xfer" pointer
points to invalid memory.  There are no break statements from this loop
so ...

1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1065  		switch (transfer_phase) {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1066  		case CMD_TRANSFER:
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1067  			/* X1 SDR mode */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1068  			cmd_config = tegra_qspi_cmd_config(false, 0,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1069  							   xfer->len);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1070  			cmd_value = *((const u8 *)(xfer->tx_buf));
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1071  			break;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1072  		case ADDR_TRANSFER:
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1073  			/* X1 SDR mode */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1074  			addr_config = tegra_qspi_addr_config(false, 0,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1075  							     xfer->len);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1076  			address_value = *((const u32 *)(xfer->tx_buf));
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1077  			break;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1078  		case DATA_TRANSFER:
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1079  			/* Program Command, Address value in register */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1080  			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1081  			tegra_qspi_writel(tqspi, address_value,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1082  					  QSPI_CMB_SEQ_ADDR);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1083  			/* Program Command and Address config in register */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1084  			tegra_qspi_writel(tqspi, cmd_config,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1085  					  QSPI_CMB_SEQ_CMD_CFG);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1086  			tegra_qspi_writel(tqspi, addr_config,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1087  					  QSPI_CMB_SEQ_ADDR_CFG);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1088  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1089  			reinit_completion(&tqspi->xfer_completion);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1090  			cmd1 = tegra_qspi_setup_transfer_one(spi, xfer,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1091  							     is_first_msg);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1092  			ret = tegra_qspi_start_transfer_one(spi, xfer,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1093  							    cmd1);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1094  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1095  			if (ret < 0) {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1096  				dev_err(tqspi->dev, "Failed to start transfer-one: %d\n",
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1097  					ret);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1098  				return ret;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1099  			}
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1100  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1101  			is_first_msg = false;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1102  			ret = wait_for_completion_timeout
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1103  					(&tqspi->xfer_completion,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1104  					QSPI_DMA_TIMEOUT);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1105  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1106  			if (WARN_ON(ret == 0)) {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1107  				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1108  					ret);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1109  				if (tqspi->is_curr_dma_xfer &&
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1110  				    (tqspi->cur_direction & DATA_DIR_TX))
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1111  					dmaengine_terminate_all
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1112  						(tqspi->tx_dma_chan);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1113  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1114  				if (tqspi->is_curr_dma_xfer &&
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1115  				    (tqspi->cur_direction & DATA_DIR_RX))
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1116  					dmaengine_terminate_all
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1117  						(tqspi->rx_dma_chan);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1118  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1119  				/* Abort transfer by resetting pio/dma bit */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1120  				if (!tqspi->is_curr_dma_xfer) {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1121  					cmd1 = tegra_qspi_readl
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1122  							(tqspi,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1123  							 QSPI_COMMAND1);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1124  					cmd1 &= ~QSPI_PIO;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1125  					tegra_qspi_writel
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1126  							(tqspi, cmd1,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1127  							 QSPI_COMMAND1);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1128  				} else {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1129  					dma_ctl = tegra_qspi_readl
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1130  							(tqspi,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1131  							 QSPI_DMA_CTL);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1132  					dma_ctl &= ~QSPI_DMA_EN;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1133  					tegra_qspi_writel(tqspi, dma_ctl,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1134  							  QSPI_DMA_CTL);
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1135  				}
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1136  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1137  				/* Reset controller if timeout happens */
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1138  				if (device_reset(tqspi->dev) < 0)
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1139  					dev_warn_once(tqspi->dev,
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1140  						      "device reset failed\n");
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1141  				ret = -EIO;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1142  				goto exit;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1143  			}
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1144  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1145  			if (tqspi->tx_status ||  tqspi->rx_status) {
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1146  				dev_err(tqspi->dev, "QSPI Transfer failed\n");
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1147  				tqspi->tx_status = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1148  				tqspi->rx_status = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1149  				ret = -EIO;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1150  				goto exit;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1151  			}
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1152  			break;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1153  		default:
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1154  			ret = -EINVAL;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1155  			goto exit;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1156  		}
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1157  		msg->actual_length += xfer->len;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1158  		transfer_phase++;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1159  	}
8777dd9dff4020 Krishna Yarlagadda 2022-10-01 @1160  	if (!xfer->cs_change) {

That means this is always wrong.

8777dd9dff4020 Krishna Yarlagadda 2022-10-01  1161  		tegra_qspi_transfer_end(spi);
8777dd9dff4020 Krishna Yarlagadda 2022-10-01  1162  		spi_transfer_delay_exec(xfer);
8777dd9dff4020 Krishna Yarlagadda 2022-10-01  1163  	}
8777dd9dff4020 Krishna Yarlagadda 2022-10-01  1164  	ret = 0;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1165  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1166  exit:
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1167  	msg->status = ret;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1168  
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1169  	return ret;
1b8342cc4a3879 Krishna Yarlagadda 2022-03-07  1170  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

