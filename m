Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFF5BE967
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiITOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiITOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:55:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B13ED41
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663685726; x=1695221726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fUwTrXpLorj5cNit/Y46mcu2qfhnBxkzoJ15r7i2d/Y=;
  b=Mj8PW0zfFli45Tdb6qE1QDpWnqHxpok3GxtyAuRtUgZxojMDrOeEsH6p
   Yszpfgp6fu+5nO41GG4Y+0C9O9IKVmwYciobpLUgs+wZgvgtRsN0kxvgg
   KeL9BWPjRh2RO69M4FbQw9X8+BX1kw/Q95xyKxGreuivgBRX8/tJHXkZn
   zOQr2agHVkjIN8NsJSPt6n5Aakk/Olb8HKukYQHuSNiWh2hSauu9eIkYB
   dUrtPltt1q29Gj4O6zcRTLoqaqNR7RzFtWQpWXI2aYnnPjvXAQgMyUN02
   hHK42TOLYQG2A2/qkZR44KbZvjOzK+FCczSB5d582+MVPLQJNXo0pnXtN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298441131"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="298441131"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="947701841"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2022 07:55:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaeeO-0002pZ-2h;
        Tue, 20 Sep 2022 14:55:04 +0000
Date:   Tue, 20 Sep 2022 22:55:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Yao <yuan.yao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 222/314]
 arch/x86/kvm/x86.c:6891:49: sparse: sparse: incorrect type in initializer
 (different address spaces)
Message-ID: <202209202202.rmtarq1l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: dbb6ce2a91250c4a951e6b1026f5cbf47ebf15e2 [222/314] KVM: Introduce the KVM_MEMORY_ENCRYPT_{READ,WRITE}_MEMORY VM ioctl
config: x86_64-randconfig-s022-20220919 (https://download.01.org/0day-ci/archive/20220920/202209202202.rmtarq1l-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/dbb6ce2a91250c4a951e6b1026f5cbf47ebf15e2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout dbb6ce2a91250c4a951e6b1026f5cbf47ebf15e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ block/ drivers/acpi/ drivers/ata/ drivers/auxdisplay/ drivers/block/ drivers/comedi/ drivers/hwmon/ drivers/infiniband/core/ drivers/infiniband/hw/qib/ drivers/net/ drivers/nvme/host/ drivers/platform/x86/ drivers/rapidio/ drivers/scsi/ drivers/staging/media/av7110/ drivers/thermal/intel/int340x_thermal/ drivers/tty/ drivers/vfio/ drivers/vhost/ drivers/watchdog/ drivers/xen/ fs/crypto/ fs/ext2/ fs/ext4/ fs/fat/ fs/quota/ fs/reiserfs/ ipc/ kernel/ net/appletalk/ net/ax25/ net/bluetooth/ net/can/ net/core/ net/dccp/ net/decnet/ net/ipv4/bpfilter/ net/llc/ net/mptcp/ net/netfilter/ net/netrom/ net/qrtr/ net/rfkill/ net/rose/ net/rxrpc/ net/sctp/ net/tls/ net/x25/ security/apparmor/ sound/core/ sound/pci/asihpi/ virt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/x86.c:228:47: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c: note: in included file:
   include/linux/kvm_host.h:1959:54: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c:254:49: sparse: sparse: array of flexible structures
   include/linux/kvm_host.h:1961:56: sparse: sparse: array of flexible structures
>> arch/x86/kvm/x86.c:6891:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct kvm_rw_memory *rw_user @@     got void [noderef] __user *argp @@
   arch/x86/kvm/x86.c:6891:49: sparse:     expected struct kvm_rw_memory *rw_user
   arch/x86/kvm/x86.c:6891:49: sparse:     got void [noderef] __user *argp
>> arch/x86/kvm/x86.c:6900:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:6900:43: sparse:     expected void [noderef] __user *to
   arch/x86/kvm/x86.c:6900:43: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:6908:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct kvm_rw_memory *rw_user @@     got void [noderef] __user *argp @@
   arch/x86/kvm/x86.c:6908:49: sparse:     expected struct kvm_rw_memory *rw_user
   arch/x86/kvm/x86.c:6908:49: sparse:     got void [noderef] __user *argp
   arch/x86/kvm/x86.c:6917:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:6917:43: sparse:     expected void [noderef] __user *to
   arch/x86/kvm/x86.c:6917:43: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:2924:9: sparse: sparse: context imbalance in '__kvm_start_pvclock_update' - wrong count at exit
   arch/x86/kvm/x86.c:2935:13: sparse: sparse: context imbalance in 'kvm_end_pvclock_update' - unexpected unlock
   arch/x86/kvm/x86.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, ...):
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_run' - unexpected unlock

vim +6891 arch/x86/kvm/x86.c

  6571	
  6572	long kvm_arch_vm_ioctl(struct file *filp,
  6573			       unsigned int ioctl, unsigned long arg)
  6574	{
  6575		struct kvm *kvm = filp->private_data;
  6576		void __user *argp = (void __user *)arg;
  6577		int r = -ENOTTY;
  6578		/*
  6579		 * This union makes it completely explicit to gcc-3.x
  6580		 * that these two variables' stack usage should be
  6581		 * combined, not added together.
  6582		 */
  6583		union {
  6584			struct kvm_pit_state ps;
  6585			struct kvm_pit_state2 ps2;
  6586			struct kvm_pit_config pit_config;
  6587		} u;
  6588	
  6589		switch (ioctl) {
  6590		case KVM_SET_TSS_ADDR:
  6591			r = kvm_vm_ioctl_set_tss_addr(kvm, arg);
  6592			break;
  6593		case KVM_SET_IDENTITY_MAP_ADDR: {
  6594			u64 ident_addr;
  6595	
  6596			mutex_lock(&kvm->lock);
  6597			r = -EINVAL;
  6598			if (kvm->created_vcpus)
  6599				goto set_identity_unlock;
  6600			r = -EFAULT;
  6601			if (copy_from_user(&ident_addr, argp, sizeof(ident_addr)))
  6602				goto set_identity_unlock;
  6603			r = kvm_vm_ioctl_set_identity_map_addr(kvm, ident_addr);
  6604	set_identity_unlock:
  6605			mutex_unlock(&kvm->lock);
  6606			break;
  6607		}
  6608		case KVM_SET_NR_MMU_PAGES:
  6609			r = kvm_vm_ioctl_set_nr_mmu_pages(kvm, arg);
  6610			break;
  6611		case KVM_GET_NR_MMU_PAGES:
  6612			r = kvm_vm_ioctl_get_nr_mmu_pages(kvm);
  6613			break;
  6614		case KVM_CREATE_IRQCHIP: {
  6615			mutex_lock(&kvm->lock);
  6616	
  6617			r = -EEXIST;
  6618			if (irqchip_in_kernel(kvm))
  6619				goto create_irqchip_unlock;
  6620	
  6621			r = -EINVAL;
  6622			if (kvm->created_vcpus)
  6623				goto create_irqchip_unlock;
  6624	
  6625			r = kvm_pic_init(kvm);
  6626			if (r)
  6627				goto create_irqchip_unlock;
  6628	
  6629			r = kvm_ioapic_init(kvm);
  6630			if (r) {
  6631				kvm_pic_destroy(kvm);
  6632				goto create_irqchip_unlock;
  6633			}
  6634	
  6635			r = kvm_setup_default_irq_routing(kvm);
  6636			if (r) {
  6637				kvm_ioapic_destroy(kvm);
  6638				kvm_pic_destroy(kvm);
  6639				goto create_irqchip_unlock;
  6640			}
  6641			/* Write kvm->irq_routing before enabling irqchip_in_kernel. */
  6642			smp_wmb();
  6643			kvm->arch.irqchip_mode = KVM_IRQCHIP_KERNEL;
  6644			kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_ABSENT);
  6645		create_irqchip_unlock:
  6646			mutex_unlock(&kvm->lock);
  6647			break;
  6648		}
  6649		case KVM_CREATE_PIT:
  6650			u.pit_config.flags = KVM_PIT_SPEAKER_DUMMY;
  6651			goto create_pit;
  6652		case KVM_CREATE_PIT2:
  6653			r = -EFAULT;
  6654			if (copy_from_user(&u.pit_config, argp,
  6655					   sizeof(struct kvm_pit_config)))
  6656				goto out;
  6657		create_pit:
  6658			mutex_lock(&kvm->lock);
  6659			r = -EEXIST;
  6660			if (kvm->arch.vpit)
  6661				goto create_pit_unlock;
  6662			r = -ENOMEM;
  6663			kvm->arch.vpit = kvm_create_pit(kvm, u.pit_config.flags);
  6664			if (kvm->arch.vpit)
  6665				r = 0;
  6666		create_pit_unlock:
  6667			mutex_unlock(&kvm->lock);
  6668			break;
  6669		case KVM_GET_IRQCHIP: {
  6670			/* 0: PIC master, 1: PIC slave, 2: IOAPIC */
  6671			struct kvm_irqchip *chip;
  6672	
  6673			chip = memdup_user(argp, sizeof(*chip));
  6674			if (IS_ERR(chip)) {
  6675				r = PTR_ERR(chip);
  6676				goto out;
  6677			}
  6678	
  6679			r = -ENXIO;
  6680			if (!irqchip_kernel(kvm))
  6681				goto get_irqchip_out;
  6682			r = kvm_vm_ioctl_get_irqchip(kvm, chip);
  6683			if (r)
  6684				goto get_irqchip_out;
  6685			r = -EFAULT;
  6686			if (copy_to_user(argp, chip, sizeof(*chip)))
  6687				goto get_irqchip_out;
  6688			r = 0;
  6689		get_irqchip_out:
  6690			kfree(chip);
  6691			break;
  6692		}
  6693		case KVM_SET_IRQCHIP: {
  6694			/* 0: PIC master, 1: PIC slave, 2: IOAPIC */
  6695			struct kvm_irqchip *chip;
  6696	
  6697			chip = memdup_user(argp, sizeof(*chip));
  6698			if (IS_ERR(chip)) {
  6699				r = PTR_ERR(chip);
  6700				goto out;
  6701			}
  6702	
  6703			r = -ENXIO;
  6704			if (!irqchip_kernel(kvm))
  6705				goto set_irqchip_out;
  6706			r = kvm_vm_ioctl_set_irqchip(kvm, chip);
  6707		set_irqchip_out:
  6708			kfree(chip);
  6709			break;
  6710		}
  6711		case KVM_GET_PIT: {
  6712			r = -EFAULT;
  6713			if (copy_from_user(&u.ps, argp, sizeof(struct kvm_pit_state)))
  6714				goto out;
  6715			r = -ENXIO;
  6716			if (!kvm->arch.vpit)
  6717				goto out;
  6718			r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
  6719			if (r)
  6720				goto out;
  6721			r = -EFAULT;
  6722			if (copy_to_user(argp, &u.ps, sizeof(struct kvm_pit_state)))
  6723				goto out;
  6724			r = 0;
  6725			break;
  6726		}
  6727		case KVM_SET_PIT: {
  6728			r = -EFAULT;
  6729			if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
  6730				goto out;
  6731			mutex_lock(&kvm->lock);
  6732			r = -ENXIO;
  6733			if (!kvm->arch.vpit)
  6734				goto set_pit_out;
  6735			r = kvm_vm_ioctl_set_pit(kvm, &u.ps);
  6736	set_pit_out:
  6737			mutex_unlock(&kvm->lock);
  6738			break;
  6739		}
  6740		case KVM_GET_PIT2: {
  6741			r = -ENXIO;
  6742			if (!kvm->arch.vpit)
  6743				goto out;
  6744			r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
  6745			if (r)
  6746				goto out;
  6747			r = -EFAULT;
  6748			if (copy_to_user(argp, &u.ps2, sizeof(u.ps2)))
  6749				goto out;
  6750			r = 0;
  6751			break;
  6752		}
  6753		case KVM_SET_PIT2: {
  6754			r = -EFAULT;
  6755			if (copy_from_user(&u.ps2, argp, sizeof(u.ps2)))
  6756				goto out;
  6757			mutex_lock(&kvm->lock);
  6758			r = -ENXIO;
  6759			if (!kvm->arch.vpit)
  6760				goto set_pit2_out;
  6761			r = kvm_vm_ioctl_set_pit2(kvm, &u.ps2);
  6762	set_pit2_out:
  6763			mutex_unlock(&kvm->lock);
  6764			break;
  6765		}
  6766		case KVM_REINJECT_CONTROL: {
  6767			struct kvm_reinject_control control;
  6768			r =  -EFAULT;
  6769			if (copy_from_user(&control, argp, sizeof(control)))
  6770				goto out;
  6771			r = -ENXIO;
  6772			if (!kvm->arch.vpit)
  6773				goto out;
  6774			r = kvm_vm_ioctl_reinject(kvm, &control);
  6775			break;
  6776		}
  6777		case KVM_SET_BOOT_CPU_ID:
  6778			r = 0;
  6779			mutex_lock(&kvm->lock);
  6780			if (kvm->created_vcpus)
  6781				r = -EBUSY;
  6782			else
  6783				kvm->arch.bsp_vcpu_id = arg;
  6784			mutex_unlock(&kvm->lock);
  6785			break;
  6786	#ifdef CONFIG_KVM_XEN
  6787		case KVM_XEN_HVM_CONFIG: {
  6788			struct kvm_xen_hvm_config xhc;
  6789			r = -EFAULT;
  6790			if (copy_from_user(&xhc, argp, sizeof(xhc)))
  6791				goto out;
  6792			r = kvm_xen_hvm_config(kvm, &xhc);
  6793			break;
  6794		}
  6795		case KVM_XEN_HVM_GET_ATTR: {
  6796			struct kvm_xen_hvm_attr xha;
  6797	
  6798			r = -EFAULT;
  6799			if (copy_from_user(&xha, argp, sizeof(xha)))
  6800				goto out;
  6801			r = kvm_xen_hvm_get_attr(kvm, &xha);
  6802			if (!r && copy_to_user(argp, &xha, sizeof(xha)))
  6803				r = -EFAULT;
  6804			break;
  6805		}
  6806		case KVM_XEN_HVM_SET_ATTR: {
  6807			struct kvm_xen_hvm_attr xha;
  6808	
  6809			r = -EFAULT;
  6810			if (copy_from_user(&xha, argp, sizeof(xha)))
  6811				goto out;
  6812			r = kvm_xen_hvm_set_attr(kvm, &xha);
  6813			break;
  6814		}
  6815		case KVM_XEN_HVM_EVTCHN_SEND: {
  6816			struct kvm_irq_routing_xen_evtchn uxe;
  6817	
  6818			r = -EFAULT;
  6819			if (copy_from_user(&uxe, argp, sizeof(uxe)))
  6820				goto out;
  6821			r = kvm_xen_hvm_evtchn_send(kvm, &uxe);
  6822			break;
  6823		}
  6824	#endif
  6825		case KVM_SET_CLOCK:
  6826			r = kvm_vm_ioctl_set_clock(kvm, argp);
  6827			break;
  6828		case KVM_GET_CLOCK:
  6829			r = kvm_vm_ioctl_get_clock(kvm, argp);
  6830			break;
  6831		case KVM_SET_TSC_KHZ: {
  6832			u32 user_tsc_khz;
  6833	
  6834			r = -EINVAL;
  6835			user_tsc_khz = (u32)arg;
  6836	
  6837			if (kvm_caps.has_tsc_control &&
  6838			    user_tsc_khz >= kvm_caps.max_guest_tsc_khz)
  6839				goto out;
  6840	
  6841			if (user_tsc_khz == 0)
  6842				user_tsc_khz = tsc_khz;
  6843	
  6844			WRITE_ONCE(kvm->arch.default_tsc_khz, user_tsc_khz);
  6845			r = 0;
  6846	
  6847			goto out;
  6848		}
  6849		case KVM_GET_TSC_KHZ: {
  6850			r = READ_ONCE(kvm->arch.default_tsc_khz);
  6851			goto out;
  6852		}
  6853		case KVM_MEMORY_ENCRYPT_OP: {
  6854			r = -ENOTTY;
  6855			if (!kvm_x86_ops.mem_enc_ioctl)
  6856				goto out;
  6857	
  6858			r = static_call(kvm_x86_mem_enc_ioctl)(kvm, argp);
  6859			break;
  6860		}
  6861		case KVM_MEMORY_ENCRYPT_REG_REGION: {
  6862			struct kvm_enc_region region;
  6863	
  6864			r = -EFAULT;
  6865			if (copy_from_user(&region, argp, sizeof(region)))
  6866				goto out;
  6867	
  6868			r = -ENOTTY;
  6869			if (!kvm_x86_ops.mem_enc_register_region)
  6870				goto out;
  6871	
  6872			r = static_call(kvm_x86_mem_enc_register_region)(kvm, &region);
  6873			break;
  6874		}
  6875		case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
  6876			struct kvm_enc_region region;
  6877	
  6878			r = -EFAULT;
  6879			if (copy_from_user(&region, argp, sizeof(region)))
  6880				goto out;
  6881	
  6882			r = -ENOTTY;
  6883			if (!kvm_x86_ops.mem_enc_unregister_region)
  6884				goto out;
  6885	
  6886			r = static_call(kvm_x86_mem_enc_unregister_region)(kvm, &region);
  6887			break;
  6888		}
  6889		case KVM_MEMORY_ENCRYPT_READ_MEMORY: {
  6890			struct kvm_rw_memory rw;
> 6891			struct kvm_rw_memory *rw_user = argp;
  6892	
  6893			r = -EFAULT;
  6894			if (copy_from_user(&rw, argp, sizeof(rw)))
  6895				goto out;
  6896	
  6897			r = -ENOTTY;
  6898			if (kvm_x86_ops.mem_enc_read_memory) {
  6899				r = static_call(kvm_x86_mem_enc_read_memory)(kvm, &rw);
> 6900				if (copy_to_user(&rw_user->len, &rw.len,
  6901						 sizeof(rw.len)))
  6902					r = -EFAULT;
  6903			}
  6904			break;
  6905		}
  6906		case KVM_MEMORY_ENCRYPT_WRITE_MEMORY: {
  6907			struct kvm_rw_memory rw;
  6908			struct kvm_rw_memory *rw_user = argp;
  6909	
  6910			r = -EFAULT;
  6911			if (copy_from_user(&rw, argp, sizeof(rw)))
  6912				goto out;
  6913	
  6914			r = -ENOTTY;
  6915			if (kvm_x86_ops.mem_enc_write_memory) {
  6916				r = static_call(kvm_x86_mem_enc_write_memory)(kvm, &rw);
  6917				if (copy_to_user(&rw_user->len, &rw.len,
  6918						 sizeof(rw.len)))
  6919					r = -EFAULT;
  6920			}
  6921			break;
  6922		}
  6923		case KVM_HYPERV_EVENTFD: {
  6924			struct kvm_hyperv_eventfd hvevfd;
  6925	
  6926			r = -EFAULT;
  6927			if (copy_from_user(&hvevfd, argp, sizeof(hvevfd)))
  6928				goto out;
  6929			r = kvm_vm_ioctl_hv_eventfd(kvm, &hvevfd);
  6930			break;
  6931		}
  6932		case KVM_SET_PMU_EVENT_FILTER:
  6933			r = kvm_vm_ioctl_set_pmu_event_filter(kvm, argp);
  6934			break;
  6935		case KVM_X86_SET_MSR_FILTER:
  6936			r = kvm_vm_ioctl_set_msr_filter(kvm, argp);
  6937			break;
  6938		default:
  6939			r = -ENOTTY;
  6940		}
  6941	out:
  6942		return r;
  6943	}
  6944	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
