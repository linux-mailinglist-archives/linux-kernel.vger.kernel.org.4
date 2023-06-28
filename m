Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE4740D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjF1Jcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjF1J1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA83595;
        Wed, 28 Jun 2023 02:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED96612A1;
        Wed, 28 Jun 2023 09:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8B4C433C9;
        Wed, 28 Jun 2023 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944369;
        bh=49cPzdV4indL7MCRWSQmY89Tv8og49dEFf+8MphaLcI=;
        h=From:To:Cc:Subject:Date:From;
        b=QvJYt69Z2rFvAx9/B2lzC+MRgbKmhtvj9MhdWwln3dgmrFSL/czeBc58JBlAuTZUB
         Bp/ry1F0L3jT0ZVAGMWyAnLyNT8ahj7c8YHMiW96JODX7Oz2r3b3aoSBqppnUjI3Ha
         P7WmLj4spSaAuIp3Zx7a+7pGLmpUUyvTeZQWdr04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.36
Date:   Wed, 28 Jun 2023 11:25:53 +0200
Message-ID: <2023062853-viper-overtone-bfea@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.36 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                    |    8 
 Makefile                                                       |    2 
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts                      |    2 
 arch/arm/boot/dts/at91sam9261ek.dts                            |    2 
 arch/arm/boot/dts/imx7d-pico-hobbit.dts                        |    2 
 arch/arm/boot/dts/imx7d-sdb.dts                                |    2 
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                            |    2 
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi             |    2 
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi                        |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi                |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi                |    2 
 arch/arm/boot/dts/omap3-pandora-common.dtsi                    |    2 
 arch/arm/boot/dts/omap5-cm-t54.dts                             |    2 
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                     |    2 
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts           |   18 
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi              |   34 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                       |   14 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                       |    7 
 arch/arm64/include/asm/sysreg.h                                |    6 
 arch/arm64/kvm/hyp/include/hyp/switch.h                        |   13 
 arch/arm64/kvm/vgic/vgic-init.c                                |   11 
 arch/s390/purgatory/Makefile                                   |    1 
 arch/x86/kernel/apic/x2apic_phys.c                             |    5 
 arch/x86/mm/kaslr.c                                            |    8 
 arch/x86/net/bpf_jit_comp.c                                    |    2 
 drivers/acpi/acpica/achware.h                                  |    2 
 drivers/acpi/sleep.c                                           |   16 
 drivers/ata/libata-core.c                                      |    3 
 drivers/ata/libata-eh.c                                        |    2 
 drivers/ata/libata-scsi.c                                      |   22 
 drivers/base/regmap/regmap-spi-avmm.c                          |    2 
 drivers/block/null_blk/main.c                                  |    1 
 drivers/char/tpm/tpm_crb.c                                     |  100 
 drivers/char/tpm/tpm_tis_core.c                                |    2 
 drivers/gpio/gpio-sifive.c                                     |    8 
 drivers/gpio/gpiolib.c                                         |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   73 
 drivers/gpu/drm/exynos/exynos_drm_g2d.c                        |    2 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                       |    2 
 drivers/gpu/drm/radeon/radeon_gem.c                            |    4 
 drivers/hid/wacom_sys.c                                        |    7 
 drivers/hv/channel_mgmt.c                                      |   18 
 drivers/hv/vmbus_drv.c                                         |    5 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c                         |    6 
 drivers/input/misc/soc_button_array.c                          |   30 
 drivers/media/cec/core/cec-adap.c                              |    8 
 drivers/media/cec/core/cec-core.c                              |    2 
 drivers/media/cec/core/cec-priv.h                              |    1 
 drivers/mmc/host/bcm2835.c                                     |    4 
 drivers/mmc/host/litex_mmc.c                                   |    1 
 drivers/mmc/host/meson-gx-mmc.c                                |   14 
 drivers/mmc/host/mmci.c                                        |    3 
 drivers/mmc/host/mtk-sd.c                                      |    2 
 drivers/mmc/host/mvsdio.c                                      |    2 
 drivers/mmc/host/omap.c                                        |    2 
 drivers/mmc/host/omap_hsmmc.c                                  |    6 
 drivers/mmc/host/owl-mmc.c                                     |    2 
 drivers/mmc/host/sdhci-acpi.c                                  |    2 
 drivers/mmc/host/sdhci-msm.c                                   |    3 
 drivers/mmc/host/sdhci-spear.c                                 |    4 
 drivers/mmc/host/sh_mmcif.c                                    |    2 
 drivers/mmc/host/sunxi-mmc.c                                   |    4 
 drivers/mmc/host/usdhi6rol0.c                                  |    6 
 drivers/net/dsa/mt7530.c                                       |   20 
 drivers/net/dsa/mt7530.h                                       |    5 
 drivers/net/ethernet/emulex/benet/be_main.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c   |    9 
 drivers/net/ethernet/qualcomm/qca_spi.c                        |    3 
 drivers/net/ethernet/sfc/ef10.c                                |   25 
 drivers/net/ethernet/sfc/ef100_nic.c                           |    7 
 drivers/net/ethernet/sfc/ef100_tx.c                            |    4 
 drivers/net/ethernet/sfc/ef100_tx.h                            |    2 
 drivers/net/ethernet/sfc/tx_common.c                           |    4 
 drivers/net/ethernet/sfc/tx_common.h                           |    2 
 drivers/net/ieee802154/mac802154_hwsim.c                       |    6 
 drivers/net/phy/dp83867.c                                      |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                  |    2 
 drivers/nfc/nfcsim.c                                           |    4 
 drivers/nvme/host/core.c                                       |   48 
 drivers/nvme/host/nvme.h                                       |    1 
 drivers/pci/controller/pci-hyperv.c                            |  139 
 drivers/platform/x86/amd/pmf/core.c                            |   10 
 drivers/s390/cio/device.c                                      |    5 
 drivers/soundwire/dmi-quirks.c                                 |    7 
 drivers/soundwire/qcom.c                                       |   17 
 drivers/spi/spi-fsl-lpspi.c                                    |    7 
 drivers/spi/spi-geni-qcom.c                                    |    2 
 drivers/target/iscsi/iscsi_target_nego.c                       |    4 
 drivers/tty/serial/fsl_lpuart.c                                |   14 
 drivers/usb/gadget/udc/amd5536udc_pci.c                        |    3 
 drivers/vhost/net.c                                            |   11 
 drivers/vhost/vdpa.c                                           |   13 
 fs/Kconfig                                                     |    9 
 fs/Makefile                                                    |    4 
 fs/btrfs/tree-log.c                                            |    2 
 fs/cifs/Kconfig                                                |  203 
 fs/cifs/Makefile                                               |   34 
 fs/cifs/asn1.c                                                 |   63 
 fs/cifs/cached_dir.c                                           |  606 
 fs/cifs/cached_dir.h                                           |   80 
 fs/cifs/cifs_debug.c                                           | 1067 -
 fs/cifs/cifs_debug.h                                           |  160 
 fs/cifs/cifs_dfs_ref.c                                         |  374 
 fs/cifs/cifs_fs_sb.h                                           |   76 
 fs/cifs/cifs_ioctl.h                                           |  126 
 fs/cifs/cifs_spnego.c                                          |  236 
 fs/cifs/cifs_spnego.h                                          |   36 
 fs/cifs/cifs_spnego_negtokeninit.asn1                          |   40 
 fs/cifs/cifs_swn.c                                             |  674 
 fs/cifs/cifs_swn.h                                             |   52 
 fs/cifs/cifs_unicode.c                                         |  632 
 fs/cifs/cifs_unicode.h                                         |  404 
 fs/cifs/cifs_uniupr.h                                          |  239 
 fs/cifs/cifsacl.c                                              | 1672 -
 fs/cifs/cifsacl.h                                              |  199 
 fs/cifs/cifsencrypt.c                                          |  733 
 fs/cifs/cifsfs.c                                               | 1857 --
 fs/cifs/cifsfs.h                                               |  161 
 fs/cifs/cifsglob.h                                             | 2208 --
 fs/cifs/cifspdu.h                                              | 2730 ---
 fs/cifs/cifsproto.h                                            |  696 
 fs/cifs/cifsroot.c                                             |   94 
 fs/cifs/cifssmb.c                                              | 5873 ------
 fs/cifs/connect.c                                              | 4754 -----
 fs/cifs/dfs_cache.c                                            | 1690 -
 fs/cifs/dfs_cache.h                                            |   97 
 fs/cifs/dir.c                                                  |  867 
 fs/cifs/dns_resolve.c                                          |   89 
 fs/cifs/dns_resolve.h                                          |   18 
 fs/cifs/export.c                                               |   54 
 fs/cifs/file.c                                                 | 5290 ------
 fs/cifs/fs_context.c                                           | 1773 --
 fs/cifs/fs_context.h                                           |  293 
 fs/cifs/fscache.c                                              |  253 
 fs/cifs/fscache.h                                              |  148 
 fs/cifs/inode.c                                                | 3093 ---
 fs/cifs/ioctl.c                                                |  526 
 fs/cifs/link.c                                                 |  650 
 fs/cifs/misc.c                                                 | 1434 -
 fs/cifs/netlink.c                                              |   90 
 fs/cifs/netlink.h                                              |   16 
 fs/cifs/netmisc.c                                              | 1021 -
 fs/cifs/nterr.c                                                |  674 
 fs/cifs/nterr.h                                                |  551 
 fs/cifs/ntlmssp.h                                              |  157 
 fs/cifs/readdir.c                                              | 1237 -
 fs/cifs/rfc1002pdu.h                                           |   61 
 fs/cifs/sess.c                                                 | 1858 --
 fs/cifs/smb1ops.c                                              | 1276 -
 fs/cifs/smb2file.c                                             |  371 
 fs/cifs/smb2glob.h                                             |   44 
 fs/cifs/smb2inode.c                                            |  799 
 fs/cifs/smb2maperror.c                                         | 2481 --
 fs/cifs/smb2misc.c                                             |  944 -
 fs/cifs/smb2ops.c                                              | 5805 ------
 fs/cifs/smb2pdu.c                                              | 5722 ------
 fs/cifs/smb2pdu.h                                              |  434 
 fs/cifs/smb2proto.h                                            |  284 
 fs/cifs/smb2status.h                                           | 1769 --
 fs/cifs/smb2transport.c                                        |  934 -
 fs/cifs/smbdirect.c                                            | 2494 --
 fs/cifs/smbdirect.h                                            |  320 
 fs/cifs/smbencrypt.c                                           |   91 
 fs/cifs/smberr.h                                               |  171 
 fs/cifs/trace.c                                                |    8 
 fs/cifs/trace.h                                                | 1070 -
 fs/cifs/transport.c                                            | 1807 --
 fs/cifs/unc.c                                                  |   69 
 fs/cifs/winucase.c                                             |  649 
 fs/cifs/xattr.c                                                |  555 
 fs/gfs2/file.c                                                 |   17 
 fs/ksmbd/Kconfig                                               |   68 
 fs/ksmbd/Makefile                                              |   20 
 fs/ksmbd/asn1.c                                                |  239 
 fs/ksmbd/asn1.h                                                |   21 
 fs/ksmbd/auth.c                                                | 1206 -
 fs/ksmbd/auth.h                                                |   71 
 fs/ksmbd/connection.c                                          |  485 
 fs/ksmbd/connection.h                                          |  231 
 fs/ksmbd/crypto_ctx.c                                          |  266 
 fs/ksmbd/crypto_ctx.h                                          |   66 
 fs/ksmbd/glob.h                                                |   49 
 fs/ksmbd/ksmbd_netlink.h                                       |  412 
 fs/ksmbd/ksmbd_spnego_negtokeninit.asn1                        |   31 
 fs/ksmbd/ksmbd_spnego_negtokentarg.asn1                        |   19 
 fs/ksmbd/ksmbd_work.c                                          |   79 
 fs/ksmbd/ksmbd_work.h                                          |  117 
 fs/ksmbd/mgmt/ksmbd_ida.c                                      |   46 
 fs/ksmbd/mgmt/ksmbd_ida.h                                      |   34 
 fs/ksmbd/mgmt/share_config.c                                   |  234 
 fs/ksmbd/mgmt/share_config.h                                   |   82 
 fs/ksmbd/mgmt/tree_connect.c                                   |  147 
 fs/ksmbd/mgmt/tree_connect.h                                   |   61 
 fs/ksmbd/mgmt/user_config.c                                    |   79 
 fs/ksmbd/mgmt/user_config.h                                    |   68 
 fs/ksmbd/mgmt/user_session.c                                   |  400 
 fs/ksmbd/mgmt/user_session.h                                   |  103 
 fs/ksmbd/misc.c                                                |  381 
 fs/ksmbd/misc.h                                                |   37 
 fs/ksmbd/ndr.c                                                 |  514 
 fs/ksmbd/ndr.h                                                 |   22 
 fs/ksmbd/nterr.h                                               |  543 
 fs/ksmbd/ntlmssp.h                                             |  169 
 fs/ksmbd/oplock.c                                              | 1722 -
 fs/ksmbd/oplock.h                                              |  127 
 fs/ksmbd/server.c                                              |  639 
 fs/ksmbd/server.h                                              |   71 
 fs/ksmbd/smb2misc.c                                            |  447 
 fs/ksmbd/smb2ops.c                                             |  314 
 fs/ksmbd/smb2pdu.c                                             | 8693 ---------
 fs/ksmbd/smb2pdu.h                                             |  536 
 fs/ksmbd/smb_common.c                                          |  797 
 fs/ksmbd/smb_common.h                                          |  468 
 fs/ksmbd/smbacl.c                                              | 1436 -
 fs/ksmbd/smbacl.h                                              |  238 
 fs/ksmbd/smbfsctl.h                                            |   91 
 fs/ksmbd/smbstatus.h                                           | 1822 --
 fs/ksmbd/transport_ipc.c                                       |  884 -
 fs/ksmbd/transport_ipc.h                                       |   47 
 fs/ksmbd/transport_rdma.c                                      | 2273 --
 fs/ksmbd/transport_rdma.h                                      |   69 
 fs/ksmbd/transport_tcp.c                                       |  649 
 fs/ksmbd/transport_tcp.h                                       |   13 
 fs/ksmbd/unicode.c                                             |  384 
 fs/ksmbd/unicode.h                                             |  358 
 fs/ksmbd/uniupr.h                                              |  268 
 fs/ksmbd/vfs.c                                                 | 1911 --
 fs/ksmbd/vfs.h                                                 |  167 
 fs/ksmbd/vfs_cache.c                                           |  708 
 fs/ksmbd/vfs_cache.h                                           |  166 
 fs/ksmbd/xattr.h                                               |  122 
 fs/nilfs2/page.c                                               |   10 
 fs/nilfs2/segbuf.c                                             |    6 
 fs/nilfs2/segment.c                                            |    7 
 fs/nilfs2/super.c                                              |   23 
 fs/smb/Kconfig                                                 |   11 
 fs/smb/Makefile                                                |    5 
 fs/smb/client/Kconfig                                          |  203 
 fs/smb/client/Makefile                                         |   34 
 fs/smb/client/asn1.c                                           |   63 
 fs/smb/client/cached_dir.c                                     |  606 
 fs/smb/client/cached_dir.h                                     |   80 
 fs/smb/client/cifs_debug.c                                     | 1067 +
 fs/smb/client/cifs_debug.h                                     |  160 
 fs/smb/client/cifs_dfs_ref.c                                   |  374 
 fs/smb/client/cifs_fs_sb.h                                     |   76 
 fs/smb/client/cifs_ioctl.h                                     |  126 
 fs/smb/client/cifs_spnego.c                                    |  236 
 fs/smb/client/cifs_spnego.h                                    |   36 
 fs/smb/client/cifs_spnego_negtokeninit.asn1                    |   40 
 fs/smb/client/cifs_swn.c                                       |  674 
 fs/smb/client/cifs_swn.h                                       |   52 
 fs/smb/client/cifs_unicode.c                                   |  632 
 fs/smb/client/cifs_unicode.h                                   |  404 
 fs/smb/client/cifs_uniupr.h                                    |  239 
 fs/smb/client/cifsacl.c                                        | 1672 +
 fs/smb/client/cifsacl.h                                        |  199 
 fs/smb/client/cifsencrypt.c                                    |  733 
 fs/smb/client/cifsfs.c                                         | 1857 ++
 fs/smb/client/cifsfs.h                                         |  161 
 fs/smb/client/cifsglob.h                                       | 2208 ++
 fs/smb/client/cifspdu.h                                        | 2730 +++
 fs/smb/client/cifsproto.h                                      |  696 
 fs/smb/client/cifsroot.c                                       |   94 
 fs/smb/client/cifssmb.c                                        | 5873 ++++++
 fs/smb/client/connect.c                                        | 4754 +++++
 fs/smb/client/dfs_cache.c                                      | 1690 +
 fs/smb/client/dfs_cache.h                                      |   97 
 fs/smb/client/dir.c                                            |  867 
 fs/smb/client/dns_resolve.c                                    |   89 
 fs/smb/client/dns_resolve.h                                    |   18 
 fs/smb/client/export.c                                         |   54 
 fs/smb/client/file.c                                           | 5290 ++++++
 fs/smb/client/fs_context.c                                     | 1773 ++
 fs/smb/client/fs_context.h                                     |  293 
 fs/smb/client/fscache.c                                        |  253 
 fs/smb/client/fscache.h                                        |  148 
 fs/smb/client/inode.c                                          | 3093 +++
 fs/smb/client/ioctl.c                                          |  526 
 fs/smb/client/link.c                                           |  650 
 fs/smb/client/misc.c                                           | 1434 +
 fs/smb/client/netlink.c                                        |   90 
 fs/smb/client/netlink.h                                        |   16 
 fs/smb/client/netmisc.c                                        | 1021 +
 fs/smb/client/nterr.c                                          |  674 
 fs/smb/client/nterr.h                                          |  551 
 fs/smb/client/ntlmssp.h                                        |  157 
 fs/smb/client/readdir.c                                        | 1237 +
 fs/smb/client/rfc1002pdu.h                                     |   61 
 fs/smb/client/sess.c                                           | 1858 ++
 fs/smb/client/smb1ops.c                                        | 1276 +
 fs/smb/client/smb2file.c                                       |  371 
 fs/smb/client/smb2glob.h                                       |   44 
 fs/smb/client/smb2inode.c                                      |  799 
 fs/smb/client/smb2maperror.c                                   | 2481 ++
 fs/smb/client/smb2misc.c                                       |  944 +
 fs/smb/client/smb2ops.c                                        | 5805 ++++++
 fs/smb/client/smb2pdu.c                                        | 5722 ++++++
 fs/smb/client/smb2pdu.h                                        |  434 
 fs/smb/client/smb2proto.h                                      |  284 
 fs/smb/client/smb2status.h                                     | 1769 ++
 fs/smb/client/smb2transport.c                                  |  934 +
 fs/smb/client/smbdirect.c                                      | 2494 ++
 fs/smb/client/smbdirect.h                                      |  320 
 fs/smb/client/smbencrypt.c                                     |   91 
 fs/smb/client/smberr.h                                         |  171 
 fs/smb/client/trace.c                                          |    8 
 fs/smb/client/trace.h                                          | 1070 +
 fs/smb/client/transport.c                                      | 1807 ++
 fs/smb/client/unc.c                                            |   69 
 fs/smb/client/winucase.c                                       |  649 
 fs/smb/client/xattr.c                                          |  555 
 fs/smb/common/Makefile                                         |    7 
 fs/smb/common/arc4.h                                           |   23 
 fs/smb/common/cifs_arc4.c                                      |   74 
 fs/smb/common/cifs_md4.c                                       |  197 
 fs/smb/common/md4.h                                            |   27 
 fs/smb/common/smb2pdu.h                                        | 1702 +
 fs/smb/common/smbfsctl.h                                       |  170 
 fs/smb/server/Kconfig                                          |   68 
 fs/smb/server/Makefile                                         |   20 
 fs/smb/server/asn1.c                                           |  239 
 fs/smb/server/asn1.h                                           |   21 
 fs/smb/server/auth.c                                           | 1206 +
 fs/smb/server/auth.h                                           |   71 
 fs/smb/server/connection.c                                     |  485 
 fs/smb/server/connection.h                                     |  231 
 fs/smb/server/crypto_ctx.c                                     |  266 
 fs/smb/server/crypto_ctx.h                                     |   66 
 fs/smb/server/glob.h                                           |   49 
 fs/smb/server/ksmbd_netlink.h                                  |  412 
 fs/smb/server/ksmbd_spnego_negtokeninit.asn1                   |   31 
 fs/smb/server/ksmbd_spnego_negtokentarg.asn1                   |   19 
 fs/smb/server/ksmbd_work.c                                     |   79 
 fs/smb/server/ksmbd_work.h                                     |  117 
 fs/smb/server/mgmt/ksmbd_ida.c                                 |   46 
 fs/smb/server/mgmt/ksmbd_ida.h                                 |   34 
 fs/smb/server/mgmt/share_config.c                              |  234 
 fs/smb/server/mgmt/share_config.h                              |   82 
 fs/smb/server/mgmt/tree_connect.c                              |  147 
 fs/smb/server/mgmt/tree_connect.h                              |   61 
 fs/smb/server/mgmt/user_config.c                               |   79 
 fs/smb/server/mgmt/user_config.h                               |   68 
 fs/smb/server/mgmt/user_session.c                              |  400 
 fs/smb/server/mgmt/user_session.h                              |  103 
 fs/smb/server/misc.c                                           |  381 
 fs/smb/server/misc.h                                           |   37 
 fs/smb/server/ndr.c                                            |  514 
 fs/smb/server/ndr.h                                            |   22 
 fs/smb/server/nterr.h                                          |  543 
 fs/smb/server/ntlmssp.h                                        |  169 
 fs/smb/server/oplock.c                                         | 1722 +
 fs/smb/server/oplock.h                                         |  127 
 fs/smb/server/server.c                                         |  646 
 fs/smb/server/server.h                                         |   71 
 fs/smb/server/smb2misc.c                                       |  454 
 fs/smb/server/smb2ops.c                                        |  314 
 fs/smb/server/smb2pdu.c                                        | 8727 ++++++++++
 fs/smb/server/smb2pdu.h                                        |  536 
 fs/smb/server/smb_common.c                                     |  797 
 fs/smb/server/smb_common.h                                     |  468 
 fs/smb/server/smbacl.c                                         | 1436 +
 fs/smb/server/smbacl.h                                         |  238 
 fs/smb/server/smbfsctl.h                                       |   91 
 fs/smb/server/smbstatus.h                                      | 1822 ++
 fs/smb/server/transport_ipc.c                                  |  884 +
 fs/smb/server/transport_ipc.h                                  |   47 
 fs/smb/server/transport_rdma.c                                 | 2273 ++
 fs/smb/server/transport_rdma.h                                 |   69 
 fs/smb/server/transport_tcp.c                                  |  649 
 fs/smb/server/transport_tcp.h                                  |   13 
 fs/smb/server/unicode.c                                        |  384 
 fs/smb/server/unicode.h                                        |  358 
 fs/smb/server/uniupr.h                                         |  268 
 fs/smb/server/vfs.c                                            | 1911 ++
 fs/smb/server/vfs.h                                            |  167 
 fs/smb/server/vfs_cache.c                                      |  708 
 fs/smb/server/vfs_cache.h                                      |  166 
 fs/smb/server/xattr.h                                          |  122 
 fs/smbfs_common/Makefile                                       |    7 
 fs/smbfs_common/arc4.h                                         |   23 
 fs/smbfs_common/cifs_arc4.c                                    |   74 
 fs/smbfs_common/cifs_md4.c                                     |  197 
 fs/smbfs_common/md4.h                                          |   27 
 fs/smbfs_common/smb2pdu.h                                      | 1702 -
 fs/smbfs_common/smbfsctl.h                                     |  170 
 include/acpi/acpixf.h                                          |    1 
 include/acpi/actbl3.h                                          |    1 
 include/linux/gpio/driver.h                                    |    8 
 include/linux/libata.h                                         |    2 
 include/linux/regulator/pca9450.h                              |    4 
 include/net/netfilter/nf_tables.h                              |   31 
 include/net/xfrm.h                                             |    1 
 include/trace/events/writeback.h                               |    2 
 io_uring/net.c                                                 |   17 
 io_uring/poll.c                                                |    9 
 kernel/bpf/btf.c                                               |   20 
 kernel/bpf/syscall.c                                           |    5 
 kernel/bpf/verifier.c                                          |   28 
 kernel/cgroup/cgroup.c                                         |   20 
 kernel/cgroup/legacy_freezer.c                                 |    8 
 kernel/time/tick-common.c                                      |   13 
 kernel/time/tick-sched.c                                       |   13 
 mm/maccess.c                                                   |   16 
 mm/memfd.c                                                     |    3 
 mm/usercopy.c                                                  |    2 
 net/core/sock.c                                                |    6 
 net/ipv4/esp4_offload.c                                        |    3 
 net/ipv4/xfrm4_input.c                                         |    1 
 net/ipv6/esp6_offload.c                                        |    3 
 net/ipv6/xfrm6_input.c                                         |    3 
 net/mptcp/protocol.c                                           |   80 
 net/mptcp/subflow.c                                            |   17 
 net/netfilter/ipvs/ip_vs_xmit.c                                |    2 
 net/netfilter/nf_tables_api.c                                  |  328 
 net/netfilter/nfnetlink_osf.c                                  |    1 
 net/netfilter/nft_immediate.c                                  |   90 
 net/netfilter/nft_set_bitmap.c                                 |    5 
 net/netfilter/nft_set_hash.c                                   |   23 
 net/netfilter/nft_set_pipapo.c                                 |   20 
 net/netfilter/nft_set_rbtree.c                                 |    5 
 net/netfilter/xt_osf.c                                         |    1 
 net/sched/sch_netem.c                                          |    8 
 net/xfrm/Makefile                                              |    2 
 net/xfrm/xfrm_input.c                                          |    1 
 net/xfrm/xfrm_interface.c                                      | 1198 -
 net/xfrm/xfrm_interface_core.c                                 | 1244 +
 net/xfrm/xfrm_policy.c                                         |   12 
 scripts/gfp-translate                                          |    6 
 sound/pci/hda/patch_realtek.c                                  |    2 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/codecs/nau8824.c                                     |   24 
 sound/soc/codecs/wcd938x-sdw.c                                 |    1 
 sound/soc/fsl/fsl_sai.c                                        |   11 
 sound/soc/fsl/fsl_sai.h                                        |    1 
 sound/soc/generic/simple-card.c                                |    1 
 tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c  |  110 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c     |    7 
 tools/testing/selftests/net/fcnal-test.sh                      |   27 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh |    4 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh |    4 
 tools/testing/selftests/net/mptcp/config                       |    1 
 tools/testing/selftests/net/mptcp/diag.sh                      |   47 
 tools/testing/selftests/net/mptcp/mptcp_connect.c              |    8 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh             |   15 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |  481 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                 |   64 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c              |   18 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh             |   20 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                |   27 
 tools/testing/selftests/net/mptcp/userspace_pm.sh              |    7 
 tools/testing/selftests/net/tls.c                              |   24 
 tools/testing/selftests/net/vrf-xfrm-tests.sh                  |   32 
 virt/kvm/kvm_main.c                                            |   20 
 456 files changed, 113366 insertions(+), 111997 deletions(-)

Alexander Gordeev (1):
      s390/purgatory: disable branch profiling

Alexei Starovoitov (1):
      mm: Fix copy_from_user_nofault().

Andreas Gruenbacher (1):
      gfs2: Don't get stuck writing page onto itself under direct I/O

Andrew Powers-Holmes (1):
      arm64: dts: rockchip: Fix rk356x PCIe register and range mappings

Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Arınç ÜNAL (3):
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
      net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
      net: dsa: mt7530: fix handling of LLDP frames

Benedict Wong (2):
      xfrm: Treat already-verified secpath entries as optional
      xfrm: Ensure policies always checked on XFRM-I input path

Chancel Liu (1):
      ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Christophe Kerello (1):
      mmc: mmci: stm32: fix max busy timeout calculation

Clark Wang (2):
      spi: lpspi: disable lpspi module irq in DMA mode
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Damien Le Moal (1):
      ata: libata-scsi: Avoid deadlock on rescan after device resume

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Danielle Ratson (1):
      selftests: forwarding: Fix race condition in mirror installation

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Dexuan Cui (6):
      Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()
      Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
      PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
      PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
      PCI: hv: Add a per-bus mutex state_lock

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Eduard Zingerman (1):
      bpf: track immediate values written to stack by BPF_ST instruction

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Eyal Birger (1):
      xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established link"

Gavin Shan (1):
      KVM: Avoid illegal stage2 mapping on invalid memory slot

Greg Kroah-Hartman (1):
      Linux 6.1.36

Hans Verkuil (2):
      media: cec: core: disable adapter in cec_devnode_unregister
      media: cec: core: don't set last_initiator if tx in progress

Hans de Goede (1):
      Input: soc_button_array - add invalid acpi_index DMI quirk handling

Herve Codina (1):
      ASoC: simple-card: Add missing of_node_put() in case of error

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Jens Axboe (4):
      io_uring/net: clear msg_controllen on partial sendmsg retry
      io_uring/net: disable partial retries for recvmsg with cmsg
      io_uring/poll: serialize poll linked timer start with poll removal
      io_uring/net: use the correct msghdr union member in io_sendmsg_copy_hdr

Jiasheng Jiang (1):
      gpio: sifive: add missing check for platform_get_irq

Jiawen Wu (1):
      gpiolib: Fix GPIO chip IRQ initialization restriction

Jiri Olsa (1):
      bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Jisheng Zhang (1):
      mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS

Krister Johansen (1):
      bpf: ensure main program has an extable

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW
      arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
      soundwire: qcom: add proper error paths in qcom_swrm_startup()

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

Lino Sanfilippo (1):
      tpm, tpm_tis: Claim locality in interrupt handler

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Maciej Żenczykowski (2):
      xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets
      revert "net: align SO_RCVMARK required privileges with SO_MARK"

Magali Lemes (3):
      selftests: net: tls: check if FIPS mode is enabled
      selftests: net: vrf-xfrm-tests: change authentication and encryption algos
      selftests: net: fcnal-test: check if FIPS mode is enabled

Marc Zyngier (2):
      arm64: Add missing Set/Way CMO encodings
      KVM: arm64: Restore GICv2-on-GICv3 functionality

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Matthew Garrett (1):
      tpm_crb: Add support for CRB devices based on Pluton

Matthieu Baerts (28):
      selftests: mptcp: remove duplicated entries in usage
      selftests: mptcp: join: fix ShellCheck warnings
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: connect: skip transp tests if not supported
      selftests: mptcp: connect: skip disconnect tests if not supported
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: pm nl: skip fullmesh flag checks if not supported
      selftests: mptcp: sockopt: relax expected returned size
      selftests: mptcp: sockopt: skip getsockopt checks if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: helpers to skip tests
      selftests: mptcp: join: skip check if MIB counter not supported
      selftests: mptcp: join: support local endpoint being tracked or not
      selftests: mptcp: join: skip Fastclose tests if not supported
      selftests: mptcp: join: support RM_ADDR for used endpoints or not
      selftests: mptcp: join: skip implicit tests if not supported
      selftests: mptcp: join: skip backup if set flag on ID not supported
      selftests: mptcp: join: skip fullmesh flag tests if not supported
      selftests: mptcp: join: skip MPC backups tests if not supported
      selftests: mptcp: diag: skip listen tests if not supported
      selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
      selftests: mptcp: join: skip test if iptables/tc cmds fail
      selftests: mptcp: join: skip userspace PM tests if not supported
      selftests: mptcp: join: skip fail tests if not supported
      selftests: mptcp: join: fix "userspace pm add & remove address"

Maurizio Lombardi (1):
      scsi: target: iscsi: Prevent login threads from racing between each other

Maxim Mikityanskiy (1):
      bpf: Fix verifier id tracking of scalars on spill

Michael Kelley (1):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Michael Walle (1):
      gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()

Min Li (2):
      drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
      drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Mukesh Sisodiya (1):
      wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0

Namjae Jeon (3):
      ksmbd: validate command payload size
      ksmbd: fix out-of-bound read in smb2_write
      ksmbd: validate session id and tree id in the compound request

Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

Nicolas Frattaroli (2):
      arm64: dts: rockchip: Enable GPU on SOQuartz CM4
      arm64: dts: rockchip: fix nEXTRST on SOQuartz

Nitesh Shetty (1):
      null_blk: Fix: memory release when memory_backed=1

Osama Muhammad (1):
      nfcsim.c: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (9):
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nft_set_pipapo: .walk does not deal with generations
      netfilter: nf_tables: disallow element updates of bound anonymous sets
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nf_tables: disallow updates of anonymous sets
      netfilter: nfnetlink_osf: fix module autoload

Paolo Abeni (4):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: add new mapping for HP Spectre x360

Prathu Baronia (1):
      scripts: fix the gfp flags header path in gfp-translate

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_template

Rafael J. Wysocki (1):
      ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Reiji Watanabe (1):
      KVM: arm64: PMU: Restore the host's PMUSERENR_EL0

Robert Hodaszi (1):
      tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Roberto Sassu (1):
      memfd: check for non-NULL file_seals in memfd_create() syscall

Rodrigo Siqueira (2):
      drm/amd/display: Use dc_update_planes_and_stream
      drm/amd/display: Add wrapper to call planes and stream update

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Russ Weight (1):
      regmap: spi-avmm: Fix regmap_bus max_raw_write

Ryusuke Konishi (2):
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Sayed, Karimuddin (1):
      ALSA: hda/realtek: Add "Intel Reference board" and "NUC 13" SSID in the ALC256

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (12):
      mmc: sdhci-spear: fix deferred probing
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing
      mmc: meson-gx: fix deferred probing
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: owl: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Shannon Nelson (1):
      vhost_vdpa: tell vqs about the negotiated

Sherry Sun (1):
      tty: serial: fsl_lpuart: make rx_watermark configurable for different platforms

Shida Zhang (1):
      btrfs: fix an uninitialized variable warning in btrfs_log_inode

Shuah Khan (1):
      selftests/mount_setattr: fix redefine struct mount_attr build error

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Register notify handler only if SPS is enabled

Sicong Jiang (1):
      ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x

Simon Horman (1):
      i2c: mchp-pci1xxxx: Avoid cast to incompatible function type

Srinivas Kandagatla (1):
      ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Stephan Gerhold (1):
      mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Steve French (2):
      smb3: missing null check in SMB2_change_notify
      smb: move client and server files to common directory fs/smb

Teresa Remmet (1):
      regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in freezer_css_{online,offline}()

Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup

Tom Chung (1):
      drm/amd/display: fix the system hang while disable PSR

Uday Shankar (3):
      nvme: double KA polling frequency to avoid KATO with TBKAS on
      nvme: check IO start time when deciding to defer KA
      nvme: improve handling of long keep alives

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong action data allocation in decap action

Yonghong Song (1):
      bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

Íñigo Huguet (1):
      sfc: use budget for TX completions

